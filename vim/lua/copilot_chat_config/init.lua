local ok_chat, chat = pcall(require, "CopilotChat")
if not ok_chat then
  -- 途中で return すると require() 側でロード済みキャッシュされ、
  -- VimEnter での再 require が再実行されないためクリアする。
  package.loaded['copilot_chat_config.init'] = nil
  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('CopilotChatConfigRetry', { clear = true }),
    once = true,
    callback = function()
      pcall(require, 'copilot_chat_config.init')
    end,
  })
  return
end

local _ = pcall(require, 'CopilotChat.utils')

chat.setup {
  -- debug = true, -- Enable debugging
  max_message_length = 60000,
  model = 'gpt-5-mini', -- デフォルトのモデルを指定
  -- system_prompt = '日本語で回答してください。',
  system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',

  mappings = {
    -- デフォルトキーをカスタマイズしたい場合
    close         = {
      normal = "q"
    },
    submit_prompt = {
      insert = "<A-Enter>",
      normal = "<CR>"
    },
  },

  -- window = {
  --   layout = 'float',
  --   width = 80, -- Fixed width in columns
  --   height = 20, -- Fixed height in rows
  --   border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
  --   title = '🦋 Copilot Chat for Neovim: ',
  --   zindex = 100, -- Ensure window stays on top
  -- },

  headers = {
    user = '🐬 You: ',
    assistant = '🦋 Copilot: ',
    tool = '🔧 Tool: ',
  },

  -- プロンプトの設定
  -- デフォルトは英語なので日本語でオーバーライドしています
  prompts = {
    -- MyCustomPrompt = {
    --   prompt = 'Explain how it works.',
    --   system_prompt = 'You are very good at explaining stuff',
    --   mapping = '<leader>ccmc',
    --   description = 'My custom prompt description',
    -- },
    Review= {
      prompt = table.concat({
        "#buffer:current",
        "",
        "コードのレビューを行ってください。",
      }, "\n"),
      -- system_prompt = '日本語で回答してください。',
      system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',
      description = '現在のバッファのコードレビューを日本語で依頼します。',
      mapping = ',ccrc',
    },
    Explain = {
      prompt = table.concat({
        "カーソル上のコードの説明を段落をつけて書いてください。",
      }, "\n"),
      -- system_prompt = '日本語で回答してください。',
      system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',
      description = 'カーソル位置のコードを日本語で段落付きで説明します。',
      mapping = ',ccre',
    },
    Test = {
      prompt = table.concat({
        "カーソル上のコードの詳細な単体テスト関数を書いてください。",
      }, "\n"),
      description = 'カーソル位置のコードに対する詳細な単体テスト関数を生成します。',
      -- system_prompt = '日本語で回答してください。',
      system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',
    },
    TestCurrent = {
      prompt = table.concat({
        "#buffer:current",
        "",
        "カーソル上のコードの詳細な単体テスト関数を書いてください。",
      }, "\n"),
      description = '現在のバッファのコードに対する詳細な単体テスト関数を生成します。',
      -- system_prompt = '日本語で回答してください。',
      system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',
    },

    -- Fix = {
    --   prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。',
    -- },

    Optimize = {
      prompt = table.concat({
        "選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
      }, "\n"),
      -- system_prompt = '日本語で回答してください。',
      system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',
      description = '選択範囲のコードを最適化し、パフォーマンスと可読性を向上させます。',
      mapping = ',ccrc',
    },

    Docs = {
      prompt = '/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）',
      description = '選択範囲のコードに適切なドキュメントコメントを追加します。',
    },

    DocsCurrent = {
      prompt = table.concat({
        "#buffer: current",
        "",
        "現在のファイルのコメントを書いてください。 \
        コメントはJSDoc等、ファイルに合わせて一般的なコメントで記述してください",
      }, "\n"),
      description = '現在のファイル全体に適切なドキュメントコメントを追加します。',
      -- system_prompt = '日本語で回答してください。',
      system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',
    },

    FixDiagnostic = {
      prompt = 'ファイル内の次のような診断上の問題を解決してください：',
      description = 'ファイル内の診断（エラーや警告）を修正します。',
    },

    Commit = {
      prompt = table.concat({
        "#shell:git diff --staged",
        "#buffer:visible",
        "",
        "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
      }, "\n"),
      description = 'ステージ済み変更のコミットメッセージをcommitizen形式で日本語生成します。',
    },

    K2Commit = {
      prompt = table.concat({
        "#shell:git diff --staged",
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
      -- コミット種別は、'feat: 新しい機能', 'fix: バグの修正', 'docs: ドキュメント変更', 'style: 空白、フォーマット、セミコロン追加など', 'refactor: リファクタリング', 'perf: パフォーマンス向上関連の変更', 'test: テスト関連の変更', 'chore: ビルド、補助ツール、ライブラリ関連の変更'とする。 \
      -- system_prompt = '日本語で回答してください。',
      system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',
      description = 'K2ルールに従ったコミットメッセージを日本語で生成します。',
      mapping = ",cck2",
    },
  }
}



vim.keymap.set("n", ",ccq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    -- system_prompt = '日本語で回答してください。',
    system_prompt = '必ず日本語で、他の言語を使わずに回答してください。',
    chat.ask("#buffer:visible\n" .. input, { system_prompt = system_prompt })
    -- chat.ask("#buffers:visible\n" .. input)
  end
end, { desc = "CopilotChat: Quick Chat" })

-- vim.keymap.set('n', ',cc', ',cc', { noremap = false })
-- vim.keymap.set('n', ',ccc', '<Cmd>CopilotChatOpen<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', ',ccp', '<Cmd>CopilotChatPrompts<CR>', { noremap = true, silent = true })



-- CopilotChatHeader          - チャットバッファ内のヘッダー部分のハイライト
-- CopilotChatSeparator       - チャットバッファ内の区切り線のハイライト
-- CopilotChatSelection       - ソースバッファでの選択範囲のハイライト
-- CopilotChatStatus          - チャットバッファ内のステータスやスピナーのハイライト
-- CopilotChatHelp            - チャットバッファ内のヘルプ文のハイライト
-- CopilotChatResource        - チャットバッファ内のリソース表記（例: #file、#gitdiff）のハイライト
-- CopilotChatTool            - チャットバッファ内のツール呼び出し（例: @copilot）のハイライト
-- CopilotChatPrompt          - チャットバッファ内のプロンプト表記（例: /Explain、/Review）のハイライト
-- CopilotChatModel           - チャットバッファ内のモデル表記（例: $gpt-4.1）のハイライト
-- CopilotChatUri             - チャットバッファ内のURI表示（例: URL not found: https://...）のハイライト
-- CopilotChatAnnotation      - ファイルヘッダーやツール呼び出しのヘッダー・本文などの注釈ハイライト
-- CopilotChatStreamingCursor - ストリーム中のカーソル（縦棒）
-- CopilotChatStreaming       - ストリーム中の本文

local function apply_copilotchat_highlights()
  vim.api.nvim_set_hl(0, 'CopilotChatHeader', { fg = '#ff0088', bold = true })
  vim.api.nvim_set_hl(0, 'CopilotChatHelp', { fg = '#6666aa' })
  vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = '#ffffff' })
  vim.api.nvim_set_hl(0, 'CopilotChatStatus', { fg = '#ff9900' })
  vim.api.nvim_set_hl(0, 'CopilotChatStreamingCursor', { fg = '#ff0099' })
  vim.api.nvim_set_hl(0, 'CopilotChatStreaming', { fg = '#eeeeee' })
end

apply_copilotchat_highlights()

local copilotchat_hl_augroup = vim.api.nvim_create_augroup('CopilotChatCustomHighlights', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = copilotchat_hl_augroup,
  callback = apply_copilotchat_highlights,
})

-- CopilotChat 側が BufEnter 時にハイライトを貼り直す/リンクするケースを吸収
vim.api.nvim_create_autocmd('BufEnter', {
  group = copilotchat_hl_augroup,
  pattern = 'copilot-*',
  callback = apply_copilotchat_highlights,
})
-- vim.api.nvim_set_hl(0, 'CopilotChatSelection',  { fg = '#ffff00', bg = '#ff0000', bold = true })
-- vim.api.nvim_set_hl(0, 'CopilotChatResource',   { fg = '#ffff00', bg = '#ff0000', bold = true })
-- vim.api.nvim_set_hl(0, 'CopilotChatTool',       { fg = '#ffff00', bg = '#ff0000', bold = true })
-- vim.api.nvim_set_hl(0, 'CopilotChatPrompt',     { fg = '#ffff00', bg = '#ff0000', bold = true })
-- vim.api.nvim_set_hl(0, 'CopilotChatModel',      { fg = '#ffff00', bg = '#ff0000', bold = true })
-- vim.api.nvim_set_hl(0, 'CopilotChatUri',        { fg = '#ffff00', bg = '#ff0000', bold = true })
-- vim.api.nvim_set_hl(0, 'CopilotChatAnnotation', { fg = '#ffff00', bg = '#ff0000', bold = true })
