--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = true,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    icons = {
      show = { git = true, folder = true, file = true, folder_arrow = true },
    },
  },
  filters = {
    dotfiles = false,
    git_ignored = false,  -- .gitignore で無視されるファイルも表示（必要なら）
  },
  actions = {
    open_file = {
      quit_on_open = true, -- ファイル開いたら閉じる
      -- quit_on_open = false,
      resize_window = false,
      window_picker = { enable = false }, -- ウィンドウ選択を無効化（誤動作減）
    },
  },
})



-- ファイラーをトグル
vim.keymap.set('n', ',eee', ':NvimTreeToggle<CR>', { silent = true, noremap = true, desc = "Toggle NvimTree" })

-- 現在のファイルをツリー上で表示
vim.keymap.set('n', ',eef', ':NvimTreeFindFile<CR>', { silent = true, noremap = true, desc = "Find current file in tree" })


-- 選択後に nvim-tree 側で現在ファイルをハイライトしたい場合
local reveal = function()
  require('nvim-tree.api').tree.find_file({ open = false, focus = false })
end
vim.keymap.set('n', ',eeg', function() require('fzf-lua').files({ actions = { ['default'] = function(...)
  require('fzf-lua').actions.file_edit(...)
  reveal()
end }}) end, { desc = 'FZF Files + Reveal in Tree' })
