---@brief
---
--- https://github.com/withastro/language-tools/tree/main/packages/language-server
---
--- `astro-ls` can be installed via `npm`:
--- ```sh
--- npm install -g @astrojs/language-server
--- ```

-- Minimal helper to locate a local TypeScript SDK (node_modules/typescript/lib)
local function find_tsdk(root_dir)
  if not root_dir then return nil end
  local match = vim.fs.find({ 'node_modules/typescript/lib' }, { upward = true, path = root_dir })[1]
  return match
end

vim.lsp.config('astro', {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git', 'astro.config.mjs' },
  init_options = {
    typescript = {},
  },
  before_init = function(_, config)
    local tsdk = find_tsdk(config.root_dir)
    if tsdk then
      config.init_options.typescript = config.init_options.typescript or {}
      -- Only set if not already specified
      if not config.init_options.typescript.tsdk then
        config.init_options.typescript.tsdk = tsdk
      end
    end
  end,
})

-- Enable astro LSP (Neovim 0.11+ API)
vim.lsp.enable('astro')
