-- keymap.vim 相当（常駐の core/editor キーマップのみ）

local map = vim.keymap.set

-- 検索のハイライト外す
map("n", "<C-l>", "<C-l>:nohlsearch<CR>", { silent = true })

-- ˜ -> ~
map({ "n", "v", "o" }, "˜", "~", { remap = false })

-- Buffer
map("n", "ln", ":next<cr>", { silent = true })
map("n", "lp", ":prev<cr>", { silent = true })

-- Tab
map("n", "tn", ":tabnext<cr>", { silent = true })
map("n", "tp", ":tabprevious<cr>", { silent = true })
map("n", "te", ":tabedit<cr>", { silent = true })
map("n", "tf", ":tabfirst<cr>", { silent = true })
map("n", "tl", ":tablast<cr>", { silent = true })

-- quickfix
map("n", "cp", ":cprevious<CR>zz", { silent = true })
map("n", "cn", ":cnext<CR>zz", { silent = true })
map("n", "cf", ":<C-u>cfirst<CR>zz", { silent = true })
map("n", "cl", ":<C-u>clast<CR>zz", { silent = true })

-- 表示行で移動
map({ "n", "v" }, "j", "gj", { noremap = true })
map({ "n", "v" }, "k", "gk", { noremap = true })

-- tab highlight
vim.opt.listchars = { tab = "  |" }

-- ハイライト（ColorScheme で上書きされるので autocmd 側で貼り直し）
