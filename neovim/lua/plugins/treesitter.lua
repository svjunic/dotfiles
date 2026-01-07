local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

-- mdx は nvim-treesitter 側で未対応なバージョンがあるため、
-- filetype は mdx のまま treesitter は markdown パーサを使うフォールバック。
pcall(function()
  vim.treesitter.language.register("markdown", "mdx")
  vim.treesitter.language.register("markdown", "markdown.mdx")
end)

configs.setup({
  ensure_installed = {
    "html",
    "css",
    "scss",
    "javascript",
    "typescript",
    "json",
    "markdown",
    "markdown_inline",
    "yaml",
    "lua",
    "bash",
    "toml",
    "vim",
    "regex",
    "tsx",
    "gitcommit",
    "git_rebase",
    "gitattributes",
    "gitignore",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = false },
  auto_install = true,
})

local function ensure_ts_started(bufnr)
  if vim.treesitter.highlighter and vim.treesitter.highlighter.active and vim.treesitter.highlighter.active[bufnr] then
    return
  end

  local ok_parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok_parser then
    return
  end

  pcall(vim.treesitter.start, bufnr)
end

local ts_fallback_group = vim.api.nvim_create_augroup("MyTSStartLua", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = ts_fallback_group,
  pattern = { "*.js", "*.mjs", "*.cjs", "*.jsx", "*.ts", "*.tsx", "*.lua", "*.vim" },
  callback = function(args)
    ensure_ts_started(args.buf)
  end,
})

-- 開発用（必要なら :SVSetDevHightlightMapping で <space> を割り当て）
vim.api.nvim_create_user_command("SVSetDevHightlightMapping", function()
  vim.keymap.set("n", "<space>", ":TSHighlightCapturesUnderCursor<CR>", { silent = true })
end, {})
