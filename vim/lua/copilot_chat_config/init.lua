local chat = require("CopilotChat")
local utils = require('CopilotChat.utils')

chat.setup {
  debug = true, -- Enable debugging
  max_message_length = 60000,
  -- model = 'o3-mini', -- デフォルトのモデルを指定
  -- model = 'claude-3.5-sonnet', -- デフォルトのモデルを指定
  model = 'gpt-4o', -- デフォルトのモデルを指定

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

  -- プロンプトの設定
  -- デフォルトは英語なので日本語でオーバーライドしています
  prompts = {
    Review= {
      prompt = '/COPILOT_REVIEW カーソル上のコードを日本語でレビューしてください。',
    },
    Explain = {
      prompt = '/COPILOT_EXPLAIN カーソル上のコードの説明を段落をつけて書いてください。',
    },
    Tests = {
      prompt = '/COPILOT_TESTS カーソル上のコードの詳細な単体テスト関数を書いてください。',
    },
    Fix = {
      prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。',
    },
    Optimize = {
      prompt = '/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。',
    },
    Docs = {
      prompt = '/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）',
    },
    FixDiagnostic = {
      prompt = 'ファイル内の次のような診断上の問題を解決してください：',
    },
    -- FixDiagnostic = {
    --   prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き直してください。日本語で返答ください。",
    -- },
    GenerateTest = {
      prompt = "/COPILOT_GENERATE このコードのテストコードを作成してください。日本語で返答ください。",
    },

    Commit = {
      prompt = table.concat({
        "#git:staged",
        "#buffers:visible",
        "",
        "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
      }, "\n"),
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
        例としては'[fix] refs #PRJ-12345 XXXの解消'という形になります。チケット番号については、gitのコミットメッセージから取得してください。",
      }, "\n"),
      mapping = "[copilot_chat]k2",
    },
  }
}

vim.keymap.set("n", "[copilot_chat]q", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    -- ##neovim://buffer//Users/jun.fujimura/virtual/github/dotfiles/vim/lua/copilot_chat_config/init.lua
    chat.ask("#buffers:visible\n" .. input)
  end
end, { desc = "CopilotChat: Quick Chat" })
