local tb = require('telescope.builtin')

require("telescope").setup{
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/", ".next", ".DS_Store" },
    hidden = true,
    borderchars = {
      "─",
      "│",
      "─",
      "│",
      "╭",
      "╮",
      "╯",
      "╰"
    },
    layout_config = {
      prompt_position = "bottom",  -- プロンプトを下に配置
      horizontal = {
        mirror = false,
        preview_width = 0.6,
      },
      vertical = {
        mirror = false,
      },
      width = 0.9,
      height = 0.9,
    },
    sorting_strategy = "ascending",
    -- layout_strategy = "vertical",
    layout_strategy = "horizontal",
    results_height = 0.5,  -- 必要に応じて高さを調整
    preview_cutoff = 120,  -- プレビューの制限
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,  -- .gitignore の無視設定を無視
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        borderchars = {
          "─",
          "│",
          "─",
          "│",
          "╭",
          "╮",
          "╯",
          "╰"
        },
        prompt_prefix = "🔍 ",
        -- previewer = false,    -- プレビューを消すことも可
      }),
    }
  }
}

require("telescope").load_extension("ui-select")
require('telescope').load_extension('fzf')
