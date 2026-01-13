return {
  -- Theme
  {
    "svjunic/RadicalGoodSpeed",
    priority = 1000,
    lazy = false,
    -- dev = true,
    -- dir = "~/virtual/github/RadicalGoodSpeed.vim",
    config = function()
      vim.cmd("colorscheme radicalgoodspeed")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ override = {}, default = true })
    end,
  },

  -- Oil
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil" },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "refractalize/oil-git-status.nvim",
    },
    config = function()
      require("config.oil")
    end,
  },
  {
    "refractalize/oil-git-status.nvim",
    lazy = true,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins.cmp")
    end,
  },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },

  -- LSP (nvim 0.11+ API)
  {
    "neovim/nvim-lspconfig",
    ft = {
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
      "vue",
      "html",
      "css",
      "json",
      "astro",
      "yaml",
      "smarty",
      "tpl",
      "mdx",
      "markdown",
      "markdown.mdx",
    },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require("plugins.lsp")
    end,
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    -- InsertEnter だと「最初の提案」までが遅くなりがちなので、対象ftで先にロードする
    ft = {
      "javascript",
      "typescript",
      "scss",
      "css",
      "html",
      "pug",
      "json",
      "astro",
      "gitcommit",
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          -- 打鍵停止後の待ち時間。小さくすると提案が出やすいがリクエスト増にもなる
          debounce = 50,
          hide_during_completion = false,
          keymap = {
            -- accept は下のカスタムマップで制御（補完ポップアップ確定と競合させない）
            accept = false,
          },
        },
        panel = { enabled = false },
        filetypes = {
          ["*"] = false,
          javascript = true,
          typescript = true,
          scss = true,
          css = true,
          html = true,
          pug = true,
          json = true,
          astro = true,
          gitcommit = true,
        },
      })

      -- <C-y> は補完ポップアップ確定に使われがちなので、
      -- 1) ポップアップ表示中は素通し
      -- 2) Copilotの提案が見えている時だけ accept
      vim.keymap.set("i", "<C-y>", function()
        local ok_s, suggestion = pcall(require, "copilot.suggestion")
        local ok_cmp, cmp = pcall(require, "cmp")

        -- 1) cmpメニューが出ていて、かつユーザーが明示的に選択している場合はcmp確定
        if ok_cmp and cmp.visible() then
          local selected = cmp.get_selected_entry()
          if selected ~= nil then
            return cmp.confirm({ select = false })
          end
        end

        -- 2) cmpが未選択なら、Copilotインライン提案が見えている時だけ受け入れる
        if ok_s and suggestion.is_visible() then
          return suggestion.accept()
        end

        -- 3) それ以外は通常の<C-y>（pumの挙動に委ねる）
        return "<C-y>"
      end, { expr = true, replace_keycodes = false, desc = "Copilot: accept suggestion" })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = { "CopilotChat", "CopilotChatOpen", "CopilotChatPrompts", "CopilotChatToggle", "CopilotChatModels" },
    ft = { "gitcommit" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { ",ccc", "<cmd>CopilotChatOpen<cr>", desc = "CopilotChat Open" },
      { ",ccp", "<cmd>CopilotChatPrompts<cr>", desc = "CopilotChat Prompts" },
    },
    config = function()
      pcall(require, "copilot_chat_config.init")
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.conform")
    end,
  },

  -- Emmet
  {
    "mattn/emmet-vim",
    ft = { "css", "scss", "html", "tsx", "astro" },
    init = function()
      vim.g.user_emmet_settings = { variables = { lang = "ja" } }
      vim.g.user_emmet_leader_key = "<C-E>"
      vim.g.user_emmet_mode = "a"
      vim.g.user_emmet_install_global = 0
      vim.keymap.set("i", "<C-L>", "<C-E>,", { remap = true })
      vim.keymap.set("v", "<C-L>", "<C-E>,", { remap = true })
    end,
    config = function()
      if vim.fn.exists(":EmmetInstall") == 2 then
        vim.cmd("EmmetInstall")
      end
    end,
  },

  -- Pug
  { "digitaltoad/vim-pug", ft = { "pug", "jade" } },
  {
    "dNitro/vim-pug-complete",
    ft = { "pug", "jade" },
    init = function()
      vim.g.html5_event_handler_attributes_complete = 0
      vim.g.html5_rdfa_attributes_complete = 0
      vim.g.html5_microdata_attributes_complete = 0
      vim.g.html5_aria_attributes_complete = 0
    end,
  },

  -- QuickRun
  {
    "thinca/vim-quickrun",
    keys = {
      { "<Leader>r", ":QuickRun<CR>", mode = "n", silent = true, desc = "QuickRun" },
      { "<Leader>r", ":<C-U>QuickRun<CR>", mode = "v", silent = true, desc = "QuickRun (visual)" },
    },
  },

  -- Test (neotest + playwright)
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-treesitter/nvim-treesitter",
      {
        "thenbe/neotest-playwright",
        dependencies = { "nvim-telescope/telescope.nvim" },
      },
    },
    config = function()
      require("plugins.neotest")
    end,
  },

  -- Editing helpers
  { "tpope/vim-surround", lazy = false },
  {
    "vim-scripts/YankRing.vim",
    lazy = false,
    init = function()
      vim.keymap.set("n", ",y", "[yankring]", { remap = true })
      vim.keymap.set("n", "[yankring]", "<Cmd>YRShow<CR>", { silent = true })
    end,
  },
  { "vim-scripts/Align", lazy = false },
  { "tpope/vim-fugitive", lazy = false },

  {
    "andymass/vim-matchup",
    event = "BufRead",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "ggandor/leap.nvim",
    lazy = false,
    init = function()
      vim.keymap.set("n", ",l", "[leap]", { remap = true })
      vim.keymap.set("n", "[leap]lf", "<Plug>(leap-forward)", { remap = true, silent = true })
      vim.keymap.set("n", "[leap]lb", "<Plug>(leap-backward)", { remap = true, silent = true })
      vim.keymap.set("n", "[leap]lw", "<Plug>(leap-from-window)", { remap = true, silent = true })
    end,
  },
}
