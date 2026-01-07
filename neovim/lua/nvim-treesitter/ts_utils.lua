local M = {}

---Compatibility shim for plugins that still require `nvim-treesitter.ts_utils`.
---Upstream removed this module, but some plugins (e.g. emmet-vim) still use it.
---We only implement what we need.

local function get_node_via_core(bufnr, row, col)
  if type(vim.treesitter.get_node) ~= "function" then
    return nil
  end

  local ok, node = pcall(vim.treesitter.get_node, { bufnr = bufnr, pos = { row, col } })
  if ok then
    return node
  end

  return nil
end

local function get_node_via_parser(bufnr, row, col)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
    return nil
  end

  local trees = parser:parse()
  local tree = trees and trees[1] or nil
  if not tree then
    return nil
  end

  local root = tree:root()
  if not root then
    return nil
  end

  return root:named_descendant_for_range(row, col, row, col)
end

---Get the Treesitter node at the cursor.
---Signature kept loose for compatibility.
---@return TSNode|nil
function M.get_node_at_cursor(winid)
  winid = winid or 0
  local bufnr = vim.api.nvim_win_get_buf(winid)

  -- Ensure a parser exists; if not, behave like old ts_utils and return nil.
  local has_parser = pcall(vim.treesitter.get_parser, bufnr)
  if not has_parser then
    return nil
  end

  local cursor = vim.api.nvim_win_get_cursor(winid)
  local row = cursor[1] - 1
  local col = cursor[2]

  return get_node_via_core(bufnr, row, col) or get_node_via_parser(bufnr, row, col)
end

return M
