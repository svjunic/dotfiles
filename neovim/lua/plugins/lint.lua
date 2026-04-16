local ok, lint = pcall(require, "lint")
if not ok then
  return
end

local function markuplint_cmd()
  local local_binary = vim.fn.fnamemodify("./node_modules/.bin/markuplint", ":p")
  return vim.loop.fs_stat(local_binary) and local_binary or "markuplint"
end

local function parse_markuplint_simple(output)
  local diagnostics = {}

  for _, line in ipairs(vim.split(output or "", "\n", { trimempty = true })) do
    local row, col, symbol, rest = line:match("^%s*(%d+):(%d+)%s+(%S+)%s+(.*)$")
    if row and col and rest then
      local message, code = rest:match("^(.-)%s%s+([%w_.-]+)%s*$")
      if message and code then
        table.insert(diagnostics, {
          lnum = tonumber(row) - 1,
          col = tonumber(col) - 1,
          message = message,
          code = code,
          severity = symbol == "⚠" and vim.diagnostic.severity.WARN or vim.diagnostic.severity.ERROR,
          source = "markuplint",
        })
      end
    end
  end

  return diagnostics
end

lint.linters.markuplint = {
  cmd = markuplint_cmd,
  args = { "--format", "Simple", "--no-color", "--problem-only", "--ignore-ext" },
  stdin = false,
  stream = "stderr",
  ignore_exitcode = true,
  parser = parse_markuplint_simple,
}

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
