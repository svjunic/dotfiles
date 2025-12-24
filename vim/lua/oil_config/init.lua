require("oil").setup({
  default_file_explorer = true,
  columns = { "icon", "permissions", "size", "mtime" },
  view_options = { show_hidden = true },
  win_options = { signcolumn = "yes:2" },
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "oil",
--   callback = function()
--     vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = true })
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.keymap.set("n", "q", "<CMD>b#<CR>", { buffer = true, silent = true, desc = "Back to previous buffer" })
  end,
})


vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Oil" })
