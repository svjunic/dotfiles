local M = {}
M._commit_target_bufnr = nil

local system_prompt_ja = "必ず日本語で、他の言語を使わずに回答してください。"

local DIFF_CONTEXT_LINES = 3
local MAX_LINES_PER_FILE = 100
local MAX_TOTAL_LINES = 500
local MAX_CHARS_PER_LINE = 1000

local function truncate_long_line(line)
  if vim.fn.strchars(line) <= MAX_CHARS_PER_LINE then
    return line, false
  end

  return vim.fn.strcharpart(line, 0, MAX_CHARS_PER_LINE) .. " … [truncated: 行が長すぎるため省略されています]", true
end

local function truncate_diff(diff)
  if diff == "" then
    return diff, false
  end

  local lines = vim.split(diff, "\n", { plain = true })
  local result = {}
  local file_line_count = 0
  local file_truncated = false
  local total_lines = 0
  local was_truncated = false

  for _, line in ipairs(lines) do
    if total_lines >= MAX_TOTAL_LINES then
      table.insert(result, "-- [truncated: 合計行数の上限 (" .. MAX_TOTAL_LINES .. " 行) に達しました。残りのファイルは省略されています]")
      was_truncated = true
      break
    end

    local is_boundary = line:match("^diff %-%-git ")
    if is_boundary then
      file_line_count = 0
      file_truncated = false
    end

    local display_line, line_truncated = truncate_long_line(line)

    if file_truncated then
      -- 次のファイル境界までスキップ
    elseif file_line_count >= MAX_LINES_PER_FILE then
      table.insert(result, "-- [truncated: このファイルの差分が " .. MAX_LINES_PER_FILE .. " 行を超えたため省略されています]")
      total_lines = total_lines + 1
      file_truncated = true
      was_truncated = true
    else
      table.insert(result, display_line)
      file_line_count = file_line_count + 1
      total_lines = total_lines + 1
      if line_truncated then
        was_truncated = true
      end
    end
  end

  return table.concat(result, "\n"), was_truncated
end

local function build_commit_prompt()
  local files_result = vim.system({
    "git",
    "diff",
    "--cached",
    "--name-only",
  }, { text = true }):wait()

  local staged_files = files_result.code == 0 and (files_result.stdout or "") or ""

  local diff_result = vim.system({
    "git",
    "diff",
    "--cached",
    "-U" .. DIFF_CONTEXT_LINES,
    "--",
    ".",
    ":(exclude)**/*.png",
    ":(exclude)**/*.jpg",
    ":(exclude)**/*.jpeg",
    ":(exclude)**/*.gif",
    ":(exclude)**/*.webp",
    ":(exclude)**/*.pdf",
    ":(exclude)**/*.zip",
    ":(exclude)**/*.gz",
    ":(exclude)**/*.tgz",
    ":(exclude)**/*.br",
    ":(exclude)**/*.min.js",
    ":(exclude)**/*.min.css",
    ":(exclude)**/*.map",
    ":(exclude)**/*.snap",
    ":(exclude)**/*.generated.*",
    ":(exclude)**/*.svg",
    ":(exclude)**/*.ttf",
    ":(exclude)**/*.otf",
    ":(exclude)**/*.woff",
    ":(exclude)**/*.woff2",
    ":(exclude)**/*.eot",
    ":(exclude)**/*.ttc",
    ":(exclude)dist/**",
    ":(exclude)build/**",
    ":(exclude).next/**",
    ":(exclude)**/package-lock.json",
    ":(exclude)**/yarn.lock",
    ":(exclude)**/pnpm-lock.yaml",
    ":(exclude)**/bun.lockb",
  }, { text = true }):wait()

  local raw_diff = diff_result.code == 0 and (diff_result.stdout or "") or ""
  local diff, was_truncated = truncate_diff(raw_diff)

  local diff_note = was_truncated
      and "（注意: 差分が長すぎるため一部省略されています。省略箇所には [truncated] マーカーが入っています）"
    or ""

  return table.concat({
    "以下はステージ済み変更です。",
    diff_note,
    "",
    "変更ファイル一覧:",
    "```text",
    staged_files ~= "" and staged_files or "(なし)",
    "```",
    "",
    "実際の差分:",
    "```diff",
    diff ~= "" and diff or "(差分なし: 除外対象ファイルのみ)",
    "```",
    "",
    "変更のコミットメッセージをcommitizenの規約に従って書いてください。",
    "",
    "下記のことを守ってください",
    "",
    "- 個人情報が含まれていないこと",
    "- 必ず日本語で書いてください",
    "- タイトルは最大50文字、メッセージは72文字で折り返してください",
    "- メッセージ全体をgitcommit言語のコードブロックで囲んでください",
    "",
    "# 出力形式",
    "- エラーがあればエラーの内容（個人情報が含まれていた場合など）",
    "- コミットメッセージ（gitcommitのブロックで出力、個人情報の有無の報告は不要）",
  }, "\n")
end

local function extract_commit_message(content)
  if not content or content == "" then
    return nil
  end

  local message = content:match("```gitcommit%s*\n(.-)\n```")
    or content:match("```%w*%s*\n(.-)\n```")
    or content

  message = vim.trim(message)
  if message == "" then
    return nil
  end

  return message
end

local function find_last_llm_message(chat)
  for index = #chat.messages, 1, -1 do
    local message = chat.messages[index]
    if message.role == "llm" and type(message.content) == "string" and message.content ~= "" then
      return message.content
    end
  end
end

local function write_commit_message_to_buffer(bufnr, content)
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
    vim.notify("CodeCompanion: commit message buffer is no longer valid", vim.log.levels.WARN)
    return
  end

  local message = extract_commit_message(content)
  if not message then
    vim.notify("CodeCompanion: commit message was empty", vim.log.levels.WARN)
    return
  end

  local message_lines = vim.split(message, "\n", { plain = true })
  local current_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local comment_start = #current_lines + 1

  for index, line in ipairs(current_lines) do
    if line:match("^#") then
      comment_start = index
      break
    end
  end

  local replacement = vim.deepcopy(message_lines)
  if comment_start <= #current_lines then
    table.insert(replacement, "")
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, comment_start - 1, false, replacement)
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd("write")
  end)
  vim.notify("CodeCompanion: commit message generated", vim.log.levels.INFO)
end

local prompt_library = {
  Review = {
    strategy = "chat",
    description = "現在のバッファのコードレビューを日本語で依頼します。",
    opts = {
      alias = "review",
      short_name = "review",
      auto_submit = true,
    },
    prompts = {
      {
        role = "system",
        content = system_prompt_ja,
      },
      {
        role = "user",
        content = table.concat({
          "#{buffer}",
          "",
          "コードのレビューを行ってください。",
        }, "\n"),
      },
    },
  },
  Explain = {
    strategy = "chat",
    description = "カーソル位置のコードを日本語で段落付きで説明します。",
    opts = {
      alias = "explain",
      short_name = "explain",
      auto_submit = true,
    },
    prompts = {
      {
        role = "system",
        content = system_prompt_ja,
      },
      {
        role = "user",
        content = "カーソル上のコードの説明を段落をつけて書いてください。",
      },
    },
  },
  Optimize = {
    strategy = "chat",
    description = "選択範囲のコードを最適化し、パフォーマンスと可読性を向上させます。",
    opts = {
      alias = "optimize",
      short_name = "optimize",
      auto_submit = true,
    },
    prompts = {
      {
        role = "system",
        content = system_prompt_ja,
      },
      {
        role = "user",
        content = "選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
      },
    },
  },
  ["Original Commit"] = {
    strategy = "chat",
    description = "ステージ済み変更のコミットメッセージをcommitizen形式で日本語生成します。",
    opts = {
      alias = "original_commit",
      short_name = "original_commit",
      auto_submit = true,
      adapter = {
        name = "copilot",
        model = "gpt-5-mini",
      },
      callbacks = {
        on_completed = function(chat)
          local target = M._commit_target_bufnr
          M._commit_target_bufnr = nil
          write_commit_message_to_buffer(target, find_last_llm_message(chat))
        end,
      },
    },
    prompts = {
      {
        role = "system",
        content = system_prompt_ja,
      },
      {
        role = "user",
        content = build_commit_prompt,
      },
    },
  },
}

require("codecompanion").setup({
  adapters = {
    http = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            top_p = {
              enabled = function(self)
                local model = self.schema.model.default
                if type(model) == "function" then
                  model = model()
                end
                return not vim.startswith(model, "o1")
                  and not model:find("codex")
                  and not vim.startswith(model, "gpt-5")
              end,
            },
          },
        })
      end,
    },
  },
  rules = {
    opts = {
      chat = {
        enabled = false,
      },
    },
  },
  interactions = {
    chat = {
      adapter = {
        name = "copilot",
        model = "gpt-5.4-mini",
      },
      roles = {
        user = "You",
        llm = "Copilot",
      },
      keymaps = {
        close = {
          modes = { n = "q" },
        },
        send = {
          callback = function(chat)
            if chat.bufnr and vim.api.nvim_buf_is_valid(chat.bufnr) then
              if type(chat._clear_status) == "function" then
                chat:_clear_status()
              end
              local ns = vim.api.nvim_create_namespace("CodeCompanion-virtual_text")
              local line = math.max(vim.api.nvim_buf_line_count(chat.bufnr) - 1, 0)
              local ok, extmark = pcall(vim.api.nvim_buf_set_extmark, chat.bufnr, ns, line, 0, {
                virt_lines = { { { "送信中...", "CodeCompanionVirtualText" } } },
                virt_lines_above = false,
              })
              if ok then
                chat._status = { extmark = extmark, submitting = true }
              end
            end
            vim.cmd("stopinsert")
            chat:submit()
          end,
          modes = { n = "<CR>", i = "<A-Enter>" },
        },
      },
      opts = {
        system_prompt = system_prompt_ja,
      },
    },
    inline = {
      adapter = "copilot",
    },
    cmd = {
      adapter = "copilot",
    },
  },
  display = {
    action_palette = {
      provider = "telescope",
      opts = {
        show_preset_prompts = false,
      },
    },
    chat = {
      window = {
        layout = "vertical",
        position = "right",
        width = 0.5,
      },
    },
  },
  prompt_library = prompt_library,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CodeCompanionCustomKeymaps", { clear = true }),
  pattern = "codecompanion",
  callback = function(args)
    vim.keymap.set("n", "q", function()
      local chat = require("codecompanion").buf_get_chat(args.buf)
      if chat and type(chat.close) == "function" then
        chat:close()
      else
        require("codecompanion").close_last_chat()
      end
    end, { buffer = args.buf, silent = true, desc = "Close CodeCompanion chat" })
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("CodeCompanionResponseNotifications", { clear = true }),
  pattern = "CodeCompanionChatDone",
  callback = function()
    vim.notify("CodeCompanion: 応答を受信しました", vim.log.levels.INFO, { title = "CodeCompanion" })
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("CodeCompanionErrorNotifications", { clear = true }),
  pattern = "CodeCompanionRequestFinished",
  callback = function(args)
    local status = args.data and args.data.status
    if status and status ~= "success" then
      vim.notify("CodeCompanion: リクエストが失敗しました (" .. status .. ")", vim.log.levels.WARN, {
        title = "CodeCompanion",
      })
    end
  end,
})

function M.prompt(alias)
  require("codecompanion").prompt(alias)
end

function M.chat_with_buffer()
  local chat = require("codecompanion").chat({ auto_submit = false })
  if chat and type(chat.add_buf_message) == "function" then
    chat:add_buf_message({ role = "user", content = "#{buffer}\n" })
  end
end

function M.quick_chat()
  vim.ui.input({ prompt = "Quick Chat: " }, function(input)
    if input == nil or input == "" then
      return
    end

    local chat = require("codecompanion").chat()
    if chat and type(chat.add_buf_message) == "function" and type(chat.submit) == "function" then
      chat:add_buf_message({ role = "user", content = "#{selection}\n" .. input })
      chat:submit()
      return
    end

    vim.api.nvim_cmd({
      cmd = "CodeCompanionChat",
      args = { "#{selection}\n" .. input },
    }, {})
  end)
end

vim.api.nvim_create_user_command("CodeCompanionOriginalCommit", function()
  M._commit_target_bufnr = vim.api.nvim_get_current_buf()
  M.prompt("original_commit")
end, {})

return M
