local ok_chat, chat = pcall(require, "CopilotChat")
if not ok_chat then
  return
end

local _ = pcall(require, "CopilotChat.utils")

local system_prompt_ja = "必ず日本語で、他の言語を使わずに回答してください。"

local prompts = {
  Review = {
    prompt = table.concat({
      "#buffer:visible",
      "",
      "コードのレビューを行ってください。",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "現在のバッファのコードレビューを日本語で依頼します。",
  },
  Explain = {
    prompt = table.concat({
      "カーソル上のコードの説明を段落をつけて書いてください。",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "カーソル位置のコードを日本語で段落付きで説明します。",
  },
  Test = {
    prompt = table.concat({
      "カーソル上のコードの詳細な単体テスト関数を書いてください。",
    }, "\n"),
    description = "カーソル位置のコードに対する詳細な単体テスト関数を生成します。",
    system_prompt = system_prompt_ja,
  },
  TestCurrent = {
    prompt = table.concat({
      "#buffer:visible",
      "",
      "カーソル上のコードの詳細な単体テスト関数を書いてください。",
    }, "\n"),
    description = "現在のバッファのコードに対する詳細な単体テスト関数を生成します。",
    system_prompt = system_prompt_ja,
  },
  Optimize = {
    prompt = table.concat({
      "選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "選択範囲のコードを最適化し、パフォーマンスと可読性を向上させます。",
  },
  Docs = {
    prompt = "/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）",
    description = "選択範囲のコードに適切なドキュメントコメントを追加します。",
  },
  DocsCurrent = {
    prompt = table.concat({
      "#buffer:visible",
      "",
      "現在のファイルのコメントを書いてください。 \\",
      "        コメントはJSDoc等、ファイルに合わせて一般的なコメントで記述してください",
    }, "\n"),
    description = "現在のファイル全体に適切なドキュメントコメントを追加します。",
    system_prompt = system_prompt_ja,
  },
  FixDiagnostic = {
    prompt = "ファイル内の次のような診断上の問題を解決してください：",
    system_prompt = system_prompt_ja,
    description = "ファイル内の診断（エラーや警告）を修正します。",
  },
  RefineSentence= {
    prompt = table.concat({
      "#buffer:visible",
      "",
      "記述されている日本語を丁寧な日本語に書き直してください。",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "記述されている日本語を丁寧な日本語に書き直してください。",
  },
  RefineMarkdown= {
    prompt = table.concat({
      "#buffer:visible",
      "",
      "記述されている内容を丁寧なマークダウンに書き直してください。",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "記述されている内容を丁寧なマークダウンに書き直してください。",
  },
  RefinePrompt= {
    prompt = table.concat({
      "#buffer:visible",
      "",
      "記述されている内容をAIエージェントに対して渡すためのプロンプトに書き直してください。",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "記述されている内容をAIエージェントに対して渡すためのプロンプトに書き直してください。",
  },
  Commit = {
    prompt = table.concat({
      "#gitdiff:staged",
      -- "",
      "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "ステージ済み変更のコミットメッセージをcommitizen形式で日本語生成します。",
  },
  viewCodeRequest = {
    prompt = table.concat({
      "#buffer:visible",
      "",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "現在のバッファに対して何かを依頼します。",
  },
  -- K2Commit = {
  --   prompt = table.concat({
  --     "#gitdiff:staged",
  --     "#buffer:visible",
  --     "",
  --     "変更のコミットメッセージを以下のルールで作成してください。",
  --     "Gitの変更履歴が分かるように、コミットメッセージは[コミット種別] refs #チケット番号 変更内容 とする。",
  --     "コミット種別は英単語で入力し、feat: 新しい機能, fix: バグの修正, docs: ドキュメント変更, style: 空白、フォーマット、セミコロン追加など, refactor: リファクタリング, perf: パフォーマンス向上関連の変更, test: テスト関連の変更, chore: ビルド、補助ツール、ライブラリ関連の変更とする。",
  --     "コメントは、差分をみて考えてください。",
  --     "[fix] refs #PRJ-12345 XXXの解消'という形になります。チケット番号については、gitのコミットメッセージから取得してください。",
  --     "特別なルールとして、下記を忘れないでください。",
  --     "publish/README.md、publish/tasks.yml、publish/src/modules配下、publish/src/classes配下、publish/src/services配下、publish/src/entrypoint.js、publish/payloads配下を変更している場合、「変更内容」のprefixとして「lmabda handler: 」をつけてください。",
  --     "astro-app配下のファイルの場合、「変更内容」のprefixとして「lmabda handler: 」をつけてください。",
  --     "src-fargate配下のファイルの場合、「変更内容」のprefixとして「fargate: 」をつけてください。",
  --     "例：",
  --     "- [fix] refs #PRJ-12345 lambnda handler: コミットメッセージ",
  --     "- [fix] refs #PRJ-12345 fargate: コミットメッセージ",
  --     "- [fix] refs #PRJ-12345 astro: コミットメッセージ",
  --     "- [feat] refs #PRJ-12345 コミットメッセージ",
  --     "- [fix] refs #PRJ-12345 コミットメッセージ",
  --     "- [docs] refs #PRJ-12345 コミットメッセージ",
  --     "- [style] refs #PRJ-12345 コミットメッセージ",
  --     "- [refactor] refs #PRJ-12345 コミットメッセージ",
  --     "- [perf] refs #PRJ-12345 コミットメッセージ",
  --     "- [test] refs #PRJ-12345 コミットメッセージ",
  --     "- [chore] refs #PRJ-12345 コミットメッセージ",
  --     "コメントは日本語で作成してください。〜しました、というものではなく言い切りの文章でOK。",
  --     "作成したコミットメッセージ全体をgitcommit言語のコードブロックで囲んでください。",
  --   }, "\n"),
  --   system_prompt = system_prompt_ja,
  --   description = "K2ルールに従ったコミットメッセージを日本語で生成します。",
  -- },
}

chat.setup({
  max_message_length = 60000,
  --model = "gpt-5.1-codex-mini",
  --model = "claude-sonnet-4.6",
  model = "gpt-5.4-mini",
  system_prompt = system_prompt_ja,
  mappings = {
    close = { normal = "q" },
    submit_prompt = { insert = "<A-Enter>", normal = "<CR>" },
  },
  tools = {
    "gitdiff:staged",
    "browser",
    "terminal",
    -- "chat",
    "diagnostics",
    "code",
    "tests",
  },
  headers = {
    user = "🐬 You: ",
    assistant = "🦋 Copilot: ",
    tool = "🔧 Tool: ",
  },
  -- window = {
  --   layout = 'float'
  -- },
  prompts = prompts,
})

-- Quick Chat
vim.keymap.set("n", ",ccq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    chat.ask("#buffer:visible\n" .. input, { system_prompt = system_prompt_ja })
  end
end, { desc = "CopilotChat: Quick Chat" })

-- Explicit keymaps to work before first CopilotChat open
vim.keymap.set("n", ",ccr", function()
  chat.ask(prompts.Review.prompt, { system_prompt = system_prompt_ja })
end, { desc = prompts.Review.description })

vim.keymap.set("n", ",cce", function()
  chat.ask(prompts.Explain.prompt, { system_prompt = system_prompt_ja })
end, { desc = prompts.Explain.description })

vim.keymap.set("n", ",cco", function()
  chat.ask(prompts.Optimize.prompt, { system_prompt = system_prompt_ja })
end, { desc = prompts.Optimize.description })

-- vim.keymap.set("n", ",cck2", function()
--   chat.ask(prompts.K2Commit.prompt, {
--     system_prompt = system_prompt_ja,
--     model = "gpt-5.1-codex-mini"
--   })
-- end, { desc = prompts.K2Commit.description })

-- Highlights
local function apply_copilotchat_highlights()
  vim.api.nvim_set_hl(0, "CopilotChatHeader", { fg = "#ff0088", bold = true })
  vim.api.nvim_set_hl(0, "CopilotChatHelp", { fg = "#6666aa" })
  vim.api.nvim_set_hl(0, "CopilotChatSeparator", { fg = "#ffffff" })
  vim.api.nvim_set_hl(0, "CopilotChatStatus", { fg = "#ff9900" })
  vim.api.nvim_set_hl(0, "CopilotChatStreamingCursor", { fg = "#ff0099" })
  vim.api.nvim_set_hl(0, "CopilotChatStreaming", { fg = "#eeeeee" })
end

apply_copilotchat_highlights()

local hl_group = vim.api.nvim_create_augroup("CopilotChatCustomHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = hl_group,
  callback = apply_copilotchat_highlights,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = hl_group,
  pattern = "copilot-*",
  callback = apply_copilotchat_highlights,
})

local DIFF_CONTEXT_LINES = 3   -- unified diff のコンテキスト行数（-U オプション）
local MAX_LINES_PER_FILE = 100 -- ファイルごとの diff 最大行数
local MAX_TOTAL_LINES = 500    -- diff 全体の最大行数
local MAX_CHARS_PER_LINE = 1000 -- 1行あたりの最大文字数

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

vim.api.nvim_create_user_command("CopilotChatOriginalCommit", function()
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

  local prompt = table.concat({
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

  chat.ask(prompt, {
    model = "gpt-5-mini",
    system_prompt = system_prompt_ja,
  })
end, {})

-- -- Custom command: CopilotChatK2Commit
-- vim.api.nvim_create_user_command("CopilotChatK2Commit", function()
--   chat.ask(prompts.K2Commit.prompt, {
--     system_prompt = prompts.K2Commit.system_prompt or system_prompt_ja,
--     model = "gpt-5.1-codex-mini"
--   })
-- end, {})
