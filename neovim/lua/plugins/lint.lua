local ok, lint = pcall(require, "lint")
if not ok then
  return
end

lint.linters_by_ft = {
  html = { "markuplint" },
  vue = { "markuplint" },
  astro = { "markuplint" },
}

local group = vim.api.nvim_create_augroup("MyNvimLint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  group = group,
  callback = function()
    lint.try_lint()
  end,
})
