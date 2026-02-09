-- nvim 0.11+ の vim.lsp.config / vim.lsp.enable を使う

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.set_log_level("off")

-- TypeScript/JavaScript
vim.lsp.config("vtsls", {
  capabilities = capabilities,
  single_file_support = true,
  settings = {
    vtsls = {
      tsserver = {
        maxTsServerMemory = 4096,
        watchOptions = {
          watchFile = "useFsEvents",
        },
        globalPlugins = {
          {
            name = "@astrojs/ts-plugin",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
      experimental = {
        completion = { enableServerSideFuzzyMatch = true },
      },
    },
    typescript = {
      locale = "ja",
      preferences = { includePackageJsonAutoImports = "off" },
    },
    javascript = {
      preferences = { includePackageJsonAutoImports = "off" },
    },
  },
})
vim.lsp.enable("vtsls")

-- Vue
vim.lsp.config("vue_ls", { capabilities = capabilities })
vim.lsp.enable("vue_ls")

-- HTML
vim.lsp.config("html", { capabilities = capabilities, filetypes = { "html", "smarty" } })
vim.lsp.enable("html")

-- CSS
vim.lsp.config("cssls", { capabilities = capabilities })
vim.lsp.enable("cssls")

-- JSON
vim.lsp.config("jsonls", { capabilities = capabilities })
vim.lsp.enable("jsonls")

-- Astro
vim.lsp.config("astro", { capabilities = capabilities })
vim.lsp.enable("astro")

-- Markdown
vim.lsp.config("marksman", {
  capabilities = capabilities,
  filetypes = { "markdown", "mdx", "markdown.mdx" },
})
-- FIX: vim/toml/plugins_lazy.toml では enable 名が astro になっていたため修正
vim.lsp.enable("marksman")

-- YAML
vim.lsp.config("yamlls", {
  capabilities = capabilities,
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
      },
    },
  },
})
vim.lsp.enable("yamlls")

-- キーマッピング
local opts = { silent = true }
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "<space>h", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "<space>a", vim.lsp.buf.code_action, opts)
vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

local function any_qf_open()
  local qf = vim.fn.getqflist({ winid = 0 })
  if qf and qf.winid and qf.winid ~= 0 then
    return true
  end
  local loc = vim.fn.getloclist(0, { winid = 0 })
  if loc and loc.winid and loc.winid ~= 0 then
    return true
  end
  return false
end

vim.keymap.set("n", "q", function()
  if any_qf_open() then
    return "<cmd>cclose<CR><cmd>lclose<CR>"
  end
  return "q"
end, { expr = true, noremap = true, silent = true })

vim.diagnostic.config({
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,

  virtual_text = {
    format = function(d)
      local msg = d.message:gsub("\n", " "):gsub("%s+", " ")
      local max = 50
      if #msg > max then msg = msg:sub(1, max) .. "…" end
      return msg
    end,
  },
  float = { wrap = true },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
  focusable = false,
  max_width = 80,
  max_height = 20,
  winblend = 0,
  zindex = 50,
})
