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

-- キーマップ
-- vim.keymap.set('n', ',fff', tb.find_files, { desc='Telescope Files' })
vim.keymap.set('n', ',ffg', tb.live_grep,  { desc='Telescope Grep'  })
vim.keymap.set('n', ',ffb', tb.buffers,    { desc='Telescope Buffers' })
vim.keymap.set('n', ',ffr', tb.oldfiles,   { desc='Telescope Recent'  })


vim.keymap.set('n', ',fff', function()
  tb.find_files({ attach_mappings = function(_, map)
    map('i','<CR>', function(prompt_bufnr)
      require('telescope.actions').select_default(prompt_bufnr)
      reveal()
    end)
    map('n','<CR>', function(prompt_bufnr)
      require('telescope.actions').select_default(prompt_bufnr)
      reveal()
    end)
    return true
  end})
end, { desc='Telescope Files (horizontal)' })

vim.keymap.set('n', ',ffF', function()
  tb.find_files({
    layout_strategy = 'vertical',
    layout_config = {
      width = 0.95,         -- ウィンドウの幅（1 で全画面）
      height = 0.95,        -- 高さ（1 で全画面）
      preview_cutoff = 0,   -- 小さい画面でもプレビューを残すかどうか
      preview_height = 0.7, -- プレビューを使う場合の高さ割合
    },
    attach_mappings = function(_, map)
      map('i','<CR>', function(prompt_bufnr)
        require('telescope.actions').select_default(prompt_bufnr)
        reveal()
      end)
      map('n','<CR>', function(prompt_bufnr)
        require('telescope.actions').select_default(prompt_bufnr)
        reveal()
      end)
    return true
  end})
end, { desc='Telescope Files (vertical)' })

