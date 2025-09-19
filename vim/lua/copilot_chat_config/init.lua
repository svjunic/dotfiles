local chat = require("CopilotChat")
local utils = require('CopilotChat.utils')

chat.setup {
  debug = true, -- Enable debugging
  max_message_length = 60000,
  model = 'gpt-4.1', -- デフォルトのモデルを指定
  system_prompt = '日本語で回答してください。',

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
        "#buffer: current",
        "",
        "コードのレビューを行ってください。",
      }, "\n"),
      system_prompt = '日本語で回答してください。',
      description = '現在のバッファのコードレビューを日本語で依頼します。',
      mapping = '[copilot_chat]rc',
    },
    Explain = {
      prompt = table.concat({
        "カーソル上のコードの説明を段落をつけて書いてください。",
      }, "\n"),
      system_prompt = '日本語で回答してください。',
      description = 'カーソル位置のコードを日本語で段落付きで説明します。',
      mapping = '[copilot_chat]re',
    },
    Test = {
      prompt = table.concat({
        "カーソル上のコードの詳細な単体テスト関数を書いてください。",
      }, "\n"),
      description = 'カーソル位置のコードに対する詳細な単体テスト関数を生成します。',
      system_prompt = '日本語で回答してください。',
    },
    TestCurrent = {
      prompt = table.concat({
        "#buffer: current",
        "",
        "カーソル上のコードの詳細な単体テスト関数を書いてください。",
      }, "\n"),
      description = '現在のバッファのコードに対する詳細な単体テスト関数を生成します。',
      system_prompt = '日本語で回答してください。',
    },

    -- Fix = {
    --   prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。',
    -- },

    Optimize = {
      prompt = table.concat({
        "選択したコードを最適化し、パフォーマンスと可読性を向上させてください。",
      }, "\n"),
      system_prompt = '日本語で回答してください。',
      description = '選択範囲のコードを最適化し、パフォーマンスと可読性を向上させます。',
      mapping = '[copilot_chat]rc',
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
      system_prompt = '日本語で回答してください。',
    },

    FixDiagnostic = {
      prompt = 'ファイル内の次のような診断上の問題を解決してください：',
      description = 'ファイル内の診断（エラーや警告）を修正します。',
    },

    Commit = {
      prompt = table.concat({
        "#git:staged",
        "#buffers:visible",
        "",
        "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
      }, "\n"),
      description = 'ステージ済み変更のコミットメッセージをcommitizen形式で日本語生成します。',
    },

    K2Commit = {
      prompt = table.concat({
        "#git:HEAD",
        "#buffers:visible",
        "",
        "変更のコミットメッセージを以下のルールで作成してください。 \
        Gitの変更履歴が分かるように、コミットメッセージは[コミット種別] refs #チケット番号 変更内容 とする。 \
        コミット種別は、'feat: 新しい機能', 'fix: バグの修正', 'docs: ドキュメント変更', 'style: 空白、フォーマット、セミコロン追加など', 'refactor: リファクタリング', 'perf: パフォーマンス向上関連の変更', 'test: テスト関連の変更', 'chore: ビルド、補助ツール、ライブラリ関連の変更'とする。 \
        コメントは、差分をみて考えてください。 \
        例としては'[fix] refs #PRJ-12345 XXXの解消'という形になります。チケット番号については、gitのコミットメッセージから取得してください。 \
        publish/README.md、publish/tasks.yml、publish/src/modules配下、publish/src/classes配下、publish/src/services配下、publish/src/entrypoint.js、publish/payloads配下を変更している場合、「変更内容」のprefixとして「lmabda handler: 」をつけてください。 \
        最後に、作成したコミットメッセージ全体をgitcommit言語のコードブロックで囲んでください。",
      }, "\n"),
      system_prompt = '日本語で回答してください。',
      description = 'K2ルールに従ったコミットメッセージを日本語で生成します。',
      mapping = "[copilot_chat]k2",
    },
  }
}

vim.keymap.set("n", "[copilot_chat]q", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    -- ##neovim://buffer//Users/jun.fujimura/virtual/github/dotfiles/vim/lua/copilot_chat_config/init.lua
    local system_prompt = "日本語で回答してください。"
    chat.ask("#buffers:visible\n" .. input, { system_prompt = system_prompt })
    -- chat.ask("#buffers:visible\n" .. input)
  end
end, { desc = "CopilotChat: Quick Chat" })
