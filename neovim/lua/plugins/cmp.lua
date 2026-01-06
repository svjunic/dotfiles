local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      local source_labels = {
        nvim_lsp = "LSP",
        buffer = "Buffer",
        path = "Path",
      }

      local kind_icons = {
        Copilot = "",
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
      }

      -- kind (left column): icon + kind name
      local icon = kind_icons[vim_item.kind]
      if icon ~= nil then
        vim_item.kind = icon .. " " .. vim_item.kind
      end

      -- menu (right column): completion source
      vim_item.menu = source_labels[entry.source.name] or entry.source.name
      return vim_item
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
  window = {
    documentation = {
      winhighlight = "Normal:CmpDocumentation",
    },
  },
  experimental = {
    ghost_text = false,
  },
})
