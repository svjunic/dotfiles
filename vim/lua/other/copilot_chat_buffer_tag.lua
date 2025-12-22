local M = {}

local function find_copilotchat_window_and_buf()
  -- CopilotChat のバッファ/ウィンドウを探す（ft は環境差があるので複数候補で）
  local fts = {
    ["copilot-chat"] = true,
    ["CopilotChat"] = true,
    ["copilotchat"] = true,
  }

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    if fts[ft] then
      return win, buf
    end
  end
  return nil, nil
end

local function put_text_in_buf(buf, text)
  -- カーソル位置に挿入（ノーマルでもインサートでもOK寄り）
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- そのバッファに移動してから挿入するほうが安全
  -- （CopilotChat の入力欄が別ウィンドウ/別バッファのことがあるため）
  local cur_win = vim.api.nvim_get_current_win()
  local target_win = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      target_win = win
      break
    end
  end
  if not target_win then return false end

  vim.api.nvim_set_current_win(target_win)
  vim.api.nvim_put({ text }, "c", true, true)
  vim.api.nvim_set_current_win(cur_win)
  -- 元のカーソルは戻したいならここで復元できるが、今回は触らない
  return true
end

local function copy_to_clipboard(text)
  vim.fn.setreg("+", text)
  vim.notify("copied: " .. text)
end

function M.pick_buffer_and_attach_tag(opts)
  opts = opts or {}
  local mode = opts.mode or "insert_or_copy" -- "insert_or_copy" | "copy" | "insert"
  local tag_kind = opts.tag_kind or "bufnr"  -- "bufnr" | "active"

  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  table.sort(buffers, function(a, b) return a.bufnr < b.bufnr end)

  local items = {}
  for _, b in ipairs(buffers) do
    local name = b.name ~= "" and vim.fn.fnamemodify(b.name, ":~:.") or "[No Name]"
    local flag = (b.changed == 1) and " ●" or ""
    table.insert(items, {
      bufnr = b.bufnr,
      label = string.format("%3d  %s%s", b.bufnr, name, flag),
    })
  end

  vim.ui.select(items, {
    prompt = "Attach buffer to CopilotChat",
    format_item = function(item) return item.label end,
  }, function(choice)
    if not choice then return end

    local tag
    if tag_kind == "active" then
      tag = "#buffer:active"
    else
      tag = "#buffer:" .. choice.bufnr
    end

    if mode == "copy" then
      return copy_to_clipboard(tag)
    end

    local _, chat_buf = find_copilotchat_window_and_buf()
    if mode == "insert" then
      if chat_buf and put_text_in_buf(chat_buf, tag) then return end
      vim.notify("CopilotChat buffer not found (use copy mode?)", vim.log.levels.WARN)
      return
    end

    -- insert_or_copy
    if chat_buf and put_text_in_buf(chat_buf, tag) then
      return
    end
    copy_to_clipboard(tag)
  end)
end

-- 例: <leader>cc で「選んで CopilotChat に挿入、なければコピー」
vim.keymap.set("n", ",ccb", function()
  require("copilotchat_buffer_tag").pick_buffer_and_attach_tag({
    mode = "insert_or_copy",
    tag_kind = "bufnr", -- ← ここを "active" にすると常に #buffer:active
  })
end, { desc = "Pick buffer → #buffer:<n> to CopilotChat (or copy)" })

-- 例: とにかく #buffer:active を入れたい派（選択不要）
vim.keymap.set("n", ",ccB", function()
  local tag = "#buffer:active"
  -- CopilotChat が開いてたら挿入、なければコピー
  local _, chat_buf = (function()
    local fts = { ["copilot-chat"]=true, ["CopilotChat"]=true, ["copilotchat"]=true }
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if fts[vim.bo[buf].filetype] then return win, buf end
    end
  end)()

  if chat_buf then
    -- ちょい簡易挿入
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == chat_buf then
        local cur = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(win)
        vim.api.nvim_put({ tag }, "c", true, true)
        vim.api.nvim_set_current_win(cur)
        return
      end
    end
  end

  vim.fn.setreg("+", tag)
  vim.notify("copied: " .. tag)
end, { desc = "Insert/copy #buffer:active" })

return M
