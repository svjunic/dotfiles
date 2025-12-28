local ok, conform = pcall(require, "conform")
if not ok then
  return
end

conform.setup({
  formatters_by_ft = {
    typescript = { "prettier", lsp_format = "fallback" },
    javascript = { "prettier", lsp_format = "fallback" },
    astro = { "prettier", lsp_format = "fallback" },
    markdown = { "prettier", lsp_format = "fallback" },
    yaml = { "prettier", lsp_format = "fallback" },
    html = { "prettier", "markuplint", lsp_format = "fallback" },
    css = { "prettier", "stylelint", lsp_format = "fallback" },
    scss = { "prettier", "stylelint", lsp_format = "fallback" },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
    quiet = false,
  },
})
