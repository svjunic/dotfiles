local tb = require('telescope.builtin')

vim.keymap.set('n', ',ffg', tb.live_grep,  { desc='Telescope Grep'  })
vim.keymap.set('n', ',ffb', tb.buffers,    { desc='Telescope Buffers' })
vim.keymap.set('n', ',ffr', tb.oldfiles,   { desc='Telescope Recent'  })


vim.keymap.set('n', ',fff', function()
  tb.find_files({ attach_mappings = function(_, map)
    map('i','<CR>', function(prompt_bufnr)
      require('telescope.actions').select_default(prompt_bufnr)
    end)
    map('n','<CR>', function(prompt_bufnr)
      require('telescope.actions').select_default(prompt_bufnr)
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
      end)
      map('n','<CR>', function(prompt_bufnr)
        require('telescope.actions').select_default(prompt_bufnr)
      end)
    return true
  end})
end, { desc='Telescope Files (vertical)' })

