local context = require('CopilotChat.context')
local select = require('CopilotChat.select')
local buffer = require('CopilotChat.select').buffer
local utils = require('CopilotChat.utils')

require("CopilotChat").setup {
  debug = true, -- Enable debugging
  max_message_length = 60000,
  -- model = 'o3-mini', -- デフォルトのモデルを指定
  -- model = 'claude-3.5-sonnet', -- デフォルトのモデルを指定
  model = 'gpt-4o', -- デフォルトのモデルを指定

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
      selection = select.diagnostics,
    },
    -- FixDiagnostic = {
    --   prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き直してください。日本語で返答ください。",
    -- },
    GenerateTest = {
      prompt = "/COPILOT_GENERATE このコードのテストコードを作成してください。日本語で返答ください。",
    },

    Commit = {
      prompt = "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
      selection = context.gitdiff,
    },
    CommitStaged = {
      prompt = "変更のコミットメッセージをcommitizenの規約に従って日本語で書いてください。タイトルは最大50文字、メッセージは72文字で折り返してください。メッセージ全体をgitcommit言語のコードブロックで囲んでください。",
      selection = function(source)
        local context = require("CopilotChat.select")
        return context.gitdiff(source, true)
      end,
    },
  }
}

-- 参考にしました。ありがとうございます。
-- https://qiita.com/lx-sasabo/items/97c49d0f354ea3bdd525

-- telescope を使ってアクションプロンプトを表示する
function ShowCopilotChatActionPrompt()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

-- キーマッピング
-- <leader>ccp (Copilot Chat Prompt の略) でアクションプロンプトを表示する
vim.api.nvim_set_keymap("n", "[copilot_chat]p", "<cmd>lua ShowCopilotChatActionPrompt()<cr>", { noremap = true, silent = true })

-- バッファの内容全体を使って Copilot とチャットする
function CopilotChatBuffer()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end

-- <leader>ccq (Copilot Chat Quick) で Copilot とチャットする
vim.api.nvim_set_keymap("n", "[copilot_chat]q", "<cmd>lua CopilotChatBuffer()<cr>", { noremap = true, silent = true })
