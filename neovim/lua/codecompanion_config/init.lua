local M = {}
M._commit_target_bufnr = nil

local system_prompt_ja = "必ず日本語で、他の言語を使わずに回答してください。"

local DIFF_CONTEXT_LINES = 3
local MAX_LINES_PER_FILE = 100
local MAX_TOTAL_LINES = 500
local MAX_CHARS_PER_LINE = 1000
local PERSONAL_INFO_DETECTED_MESSAGE = "個人情報が含まれている可能性があります。コミットメッセージは生成しません。"

local function env_or_default(name, default)
  local value = os.getenv(name)
  if value == nil or vim.trim(value) == "" then
    return default
  end
  return value
end

local function env_bool(name)
  local value = os.getenv(name)
  if value == nil or vim.trim(value) == "" then
    return nil
  end

  value = vim.trim(value):lower()
  if value == "true" or value == "1" or value == "yes" or value == "on" then
    return true
  end
  if value == "false" or value == "0" or value == "no" or value == "off" then
    return false
  end
  return nil
end

local function original_commit_adapter()
  return {
    name = env_or_default("LLM_SERVICE", "copilot"),
    model = env_or_default("LLM_MODEL", "gpt-5-mini"),
  }
end

local function resolve_adapter_model(adapter)
  if type(adapter.model) == "table" and adapter.model.name then
    return adapter.model.name
  end
  if type(adapter.model) == "string" then
    return adapter.model
  end

  local schema_model = adapter.schema and adapter.schema.model and adapter.schema.model.default
  if type(schema_model) == "function" then
    local ok, model = pcall(schema_model, adapter)
    if ok then
      return model
    end
    return nil
  end
  return schema_model
end

local function llm_role_name(adapter)
  local service = adapter.name or "unknown"
  local model = resolve_adapter_model(adapter) or "unknown"
  return "Assistant(" .. service .. "/" .. model .. ")"
end

local function truncate_long_line(line)
  if vim.fn.strchars(line) <= MAX_CHARS_PER_LINE then
    return line, false
  end

  return "-- [truncated: この行は長すぎるため全文を省略しました]", true
end

local function truncate_long_lines_only(diff)
  if diff == "" then
    return diff, false
  end

  local lines = vim.split(diff, "\n", { plain = true })
  local was_truncated = false

  for index, line in ipairs(lines) do
    local display_line, line_truncated = truncate_long_line(line)
    lines[index] = display_line
    if line_truncated then
      was_truncated = true
    end
  end

  return table.concat(lines, "\n"), was_truncated
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


local function close_unbalanced_code_block(text)
  if text == nil or text == "" then
    return text, false
  end

  local fence_count = 0
  for _ in text:gmatch("```") do
    fence_count = fence_count + 1
  end

  if fence_count % 2 == 1 then
    return text .. "\n```", true
  end

  return text, false
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
  -- テストのため、差分の省略処理を一時的に無効化してプロンプトへそのまま渡す。
  -- local diff, was_truncated = truncate_diff(raw_diff)
  -- local diff_closed = false
  -- diff, diff_closed = close_unbalanced_code_block(diff)
  -- if diff_closed then
  --   was_truncated = true
  -- end
  local diff, was_truncated = truncate_long_lines_only(raw_diff)

  local diff_note = was_truncated
      and "差分内の長すぎる行は [truncated] マーカーに置換されています。省略された内容は推測せず、[truncated] やこの注意文をコミットメッセージに含めないでください。"
    or ""

  return table.concat({
    "下記のルールで、変更のコミットメッセージを書いてください。",
    "",
    "- 必ずcommitizenの規約に沿ったメッセージにする",
    "- 必ず日本語で書く",
    "- 出力はコミットメッセージのみとし、説明・注釈・コードブロックは出力しない",
    "- 必ず個人情報が含まれていないか確認する",
    "- 個人情報が含まれている場合は、コミットメッセージを出力せず「"
      .. PERSONAL_INFO_DETECTED_MESSAGE
      .. "」のみを出力する",
    "- 個人情報が含まれていない場合は、個人情報に関する説明を出力せず、コミットメッセージのみを出力する",
    "",
    "出力形式: ",
    "",
    "```text",
    "<type>(<scope>): <subject>",
    "<br />",
    "<body:subjectだけでは保管できない説明を追記>",
    "<br />",
    "<footer:変更内容の-で箇条書き>",
    "```",
    "",
    "メッセージのルール: ",
    "- <type>、<scope>は、英語にすること",
    "- <subject>、<body>、<footer> は、日本語にすること",
    "- <footer> は Breaking Change や issue 参照などが必要な場合のみ書くこと",
    "- <subject>は、最大50文字とする",
    "- メッセージは、72文字で折り返し",
    "- メッセージは、全角句点「。」の直後で必ず改行する",
    "- メッセージには、コードブロックを記述しない",
    "- Note: や注意書きなど、差分メタ情報をコミットメッセージに書かない",
    "- 改行する際に改行という文字をいれない",
    "- フッターが不要の場合は、何も書かない",
    "- [truncated] マーカーをコミットメッセージに書かない",
    "",
    "<type> に入る文字のルール: ",
    "",
    "下記の中から type だけを選択してください。説明文は出力に含めないでください。",
    "- feat",
    "- fix",
    "- docs",
    "- style",
    "- refactor",
    "- perf",
    "- test",
    "- build",
    "- ci",
    "- chore",
    "",
    "注意: ",
    "個人情報が含まれていた場合は、コミットメッセージを出力しないこと",
    "個人情報が含まれていない場合は、「個人情報はありません」などの説明を出力しないこと",
    diff_note,
    "",
    "---",
    "差分の情報: ",
    "以下はステージ済み変更です。",
    "",
    "変更ファイル一覧: ",
    "```text",
    staged_files ~= "" and staged_files or "(なし)",
    "```",
    "",
    "差分: ",
    "```",
    diff ~= "" and diff or "(差分なし: 除外対象ファイルのみ)",
    "```",
  }, "\n")
end

local function extract_commit_message(content)
  if not content or content == "" then
    return nil
  end

  content = content:gsub("\r\n", "\n"):gsub("\r", "\n")

  local message = content:match("```gitcommit%s*\n(.-)\n```")
    or content:match("```git%-commit%s*\n(.-)\n```")
    or content:match("```[%w_-]*%s*\n(.-)\n```")
    or content

  message = vim.trim(message)
  if message == "" then
    return nil
  end
  if message == PERSONAL_INFO_DETECTED_MESSAGE then
    return nil, "personal_info_detected"
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

  local message, reason = extract_commit_message(content)
  if reason == "personal_info_detected" then
    vim.notify(PERSONAL_INFO_DETECTED_MESSAGE, vim.log.levels.WARN, { title = "CodeCompanion" })
    return
  end
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
      adapter = original_commit_adapter(),
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
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            think = {
              default = function(self)
                local think = env_bool("LLM_THINK")
                if think ~= nil then
                  return think
                end
                return require("codecompanion.adapters.http.ollama.get_models").check_thinking_capability(self)
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
        llm = llm_role_name,
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

function M.inline_edit_with_buffer()
  vim.ui.input({ prompt = "Inline Edit: " }, function(input)
    if input == nil or vim.trim(input) == "" then
      return
    end

    require("codecompanion").inline({
      args = "#{buffer}\n" .. input,
    })
  end)
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
