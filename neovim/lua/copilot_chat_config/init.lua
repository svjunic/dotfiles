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
    description = "ファイル内の診断（エラーや警告）を修正します。",
  },
  Commit = {
    prompt = table.concat({
      "#gitdiff:staged",
      "#buffer:visible",
      "",
      "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
    }, "\n"),
    description = "ステージ済み変更のコミットメッセージをcommitizen形式で日本語生成します。",
  },
  K2Commit = {
    prompt = table.concat({
      "#gitdiff:staged",
      "#buffer:visible",
      "",
      "変更のコミットメッセージを以下のルールで作成してください。",
      "Gitの変更履歴が分かるように、コミットメッセージは[コミット種別] refs #チケット番号 変更内容 とする。",
      "コミット種別は英単語で入力し、feat: 新しい機能, fix: バグの修正, docs: ドキュメント変更, style: 空白、フォーマット、セミコロン追加など, refactor: リファクタリング, perf: パフォーマンス向上関連の変更, test: テスト関連の変更, chore: ビルド、補助ツール、ライブラリ関連の変更とする。",
      "コメントは、差分をみて考えてください。",
      "[fix] refs #PRJ-12345 XXXの解消'という形になります。チケット番号については、gitのコミットメッセージから取得してください。",
      "特別なルールとして、下記を忘れないでください。",
      "publish/README.md、publish/tasks.yml、publish/src/modules配下、publish/src/classes配下、publish/src/services配下、publish/src/entrypoint.js、publish/payloads配下を変更している場合、「変更内容」のprefixとして「lmabda handler: 」をつけてください。",
      "astro-app配下のファイルの場合、「変更内容」のprefixとして「lmabda handler: 」をつけてください。",
      "src-fargate配下のファイルの場合、「変更内容」のprefixとして「fargate: 」をつけてください。",
      "例：",
      "- [fix] refs #PRJ-12345 lambnda handler: コミットメッセージ",
      "- [fix] refs #PRJ-12345 fargate: コミットメッセージ",
      "- [fix] refs #PRJ-12345 astro: コミットメッセージ",
      "- [feat] refs #PRJ-12345 コミットメッセージ",
      "- [fix] refs #PRJ-12345 コミットメッセージ",
      "- [docs] refs #PRJ-12345 コミットメッセージ",
      "- [style] refs #PRJ-12345 コミットメッセージ",
      "- [refactor] refs #PRJ-12345 コミットメッセージ",
      "- [perf] refs #PRJ-12345 コミットメッセージ",
      "- [test] refs #PRJ-12345 コミットメッセージ",
      "- [chore] refs #PRJ-12345 コミットメッセージ",
      "コメントは日本語で作成してください。〜しました、というものではなく言い切りの文章でOK。",
      "最後に、作成したコミットメッセージ全体をgitcommit言語のコードブロックで囲んでください。",
    }, "\n"),
    system_prompt = system_prompt_ja,
    description = "K2ルールに従ったコミットメッセージを日本語で生成します。",
  },
}

chat.setup({
  max_message_length = 60000,
  --model = "gpt-5.1-codex-mini",
  model = "gpt-5-mini",
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

vim.keymap.set("n", ",ccre", function()
  chat.ask(prompts.Explain.prompt, { system_prompt = system_prompt_ja })
end, { desc = prompts.Explain.description })

vim.keymap.set("n", ",cco", function()
  chat.ask(prompts.Optimize.prompt, { system_prompt = system_prompt_ja })
end, { desc = prompts.Optimize.description })

vim.keymap.set("n", ",cck2", function()
  chat.ask(prompts.K2Commit.prompt, {
    system_prompt = system_prompt_ja,
    model = "gpt-5-mini"
  })
end, { desc = prompts.K2Commit.description })

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

-- Custom command: CopilotChatK2Commit (this repo's legacy)
vim.api.nvim_create_user_command("CopilotChatK2Commit", function()
  chat.ask(prompts.K2Commit.prompt, {
    system_prompt = prompts.K2Commit.system_prompt or system_prompt_ja,
    model = "gpt-5-mini"
  })
end, {})
