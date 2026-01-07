-- auto.vim + keymap.vim の自動処理を最小安全で移植

local function apply_custom_highlights()
  vim.api.nvim_set_hl(0, "LogNormal", { fg = "#5fd7ff", bg = "#005f5f", underline = true })
  vim.api.nvim_set_hl(0, "LogWarn", { fg = "#ffd700", bold = true, underline = true })
  vim.api.nvim_set_hl(0, "LogError", { fg = "#ff5f87", bold = true, underline = true })
  vim.api.nvim_set_hl(0, "LogFatal", { fg = "#ff5f00", bold = true, underline = true })

  vim.api.nvim_set_hl(0, "ZenkakuSpace", { reverse = true })
  -- vim.api.nvim_set_hl(0, "CurlyBracket", { fg = "#00bfff" })
end

local function ensure_window_matches()
  if vim.w.custom_matchadd_ids ~= nil then
    return
  end

  local ids = {}
  local function add(group, pattern)
    table.insert(ids, vim.fn.matchadd(group, pattern, 200))
  end

  -- TODO/LOG 系
  add("Todo", "\\W\\zs\\(TODO\\|FIXME\\|CHANGED\\|XXX\\|BUG\\|HACK\\|NOTE\\|INFO\\|IDEA\\)")
  add("LogNormal", "\\W\\zs\\[\\(INFO\\|DEBUG\\|TRACE\\)\\]")
  add("LogWarn", "\\W\\zs\\[\\(WARN\\)\\]")
  add("LogError", "\\W\\zs\\[\\(ERROR\\)\\]")
  add("LogFatal", "\\W\\zs\\[\\(FATAL\\)\\]")

  add("LogNormal", "\\(INFO\\|DEBUG\\|TRACE\\)")
  add("LogWarn", "\\(WARN\\)")
  add("LogError", "\\(ERROR\\)")
  add("LogFatal", "\\(FATAL\\)")

  -- keymap.vim 側の全角スペース/波括弧（vim の `:match` は上書きされるので matchadd に寄せる）
  add("ZenkakuSpace", "　")
  add("CurlyBracket", "[{}]")

  vim.w.custom_matchadd_ids = ids
end

local group = vim.api.nvim_create_augroup("MyCustomHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = apply_custom_highlights,
})
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "Syntax" }, {
  group = group,
  callback = ensure_window_matches,
})

apply_custom_highlights()

-- scss のときだけリロード確認を頻繁に行う
local scss_group = vim.api.nvim_create_augroup("scss", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = scss_group,
  pattern = "*.scss",
  callback = function()
    vim.opt_local.autoread = true
  end,
})
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  group = scss_group,
  pattern = "*.scss",
  callback = function()
    vim.cmd("checktime")
  end,
})

-- Git commit message: CopilotChatK2Commit
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MyGitCommit", { clear = true }),
  pattern = "gitcommit",
  callback = function()
    if vim.fn.exists(":CopilotChatK2Commit") == 2 then
      vim.cmd("CopilotChatK2Commit")
    end
  end,
})

-- filetype 追加
vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
  pattern = {
    ["Dockerfile%-.+"] = "dockerfile",
    [".*/Dockerfile%-.+"] = "dockerfile",
  },
})
