local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local themes = require("telescope.themes")

telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/", ".next", ".DS_Store" },
    hidden = true,
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        mirror = false,
        preview_width = 0.6,
      },
      vertical = {
        mirror = false,
      },
      width = 0.9,
      height = 0.9,
    },
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    results_height = 0.5,
    preview_cutoff = 120,
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,
    },
    -- 最小侵襲: live_grep だけ hidden 対応する
    live_grep = {
      additional_args = function()
        return { "--hidden", "--glob", "!.git/*" }
      end,
    },
  },
  extensions = {
    ["ui-select"] = themes.get_dropdown({
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      prompt_prefix = "🔍 ",
    }),
  },
})

pcall(telescope.load_extension, "ui-select")
pcall(telescope.load_extension, "fzf")

local ext = telescope.extensions and telescope.extensions["ui-select"]
if ext and type(ext.select) == "function" then
  vim.ui.select = ext.select
end

-- キーマップ（vim/lua/telescope_config/keymap.lua 相当）
local tb = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- 絞り込んだファイルをすべて開くアクション
local function open_all_filtered(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local manager = picker.manager
  
  local entries = {}
  for entry in manager:iter() do
    table.insert(entries, entry)
  end
  
  actions.close(prompt_bufnr)
  
  if #entries == 0 then
    return
  end
  
  -- 最初のファイルは現在のバッファで開く
  vim.cmd("e " .. vim.fn.fnameescape(entries[1].value or entries[1].filename or entries[1].path or entries[1][1]))
  
  -- 残りのファイルをタブで開く
  for i = 2, #entries do
    local file = entries[i].value or entries[i].filename or entries[i].path or entries[i][1]
    vim.cmd("tabnew " .. vim.fn.fnameescape(file))
  end
end

vim.keymap.set("n", ",ffg", tb.live_grep, { desc = "Telescope Grep" })
vim.keymap.set("n", ",ffb", tb.buffers, { desc = "Telescope Buffers" })
vim.keymap.set("n", ",ffr", tb.oldfiles, { desc = "Telescope Recent" })

vim.keymap.set("n", ",fff", function()
  tb.find_files({
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        actions.select_default(prompt_bufnr)
      end)
      map("n", "<CR>", function(prompt_bufnr)
        actions.select_default(prompt_bufnr)
      end)
      -- 絞り込んだファイルをすべて開く（Ctrl-a）
      map("i", "<C-a>", open_all_filtered)
      map("n", "<C-a>", open_all_filtered)
      return true
    end,
  })
end, { desc = "Telescope Files (horizontal)" })

vim.keymap.set("n", ",ffF", function()
  tb.find_files({
    layout_strategy = "vertical",
    layout_config = {
      width = 0.95,
      height = 0.95,
      preview_cutoff = 0,
      preview_height = 0.7,
    },
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        actions.select_default(prompt_bufnr)
      end)
      map("n", "<CR>", function(prompt_bufnr)
        actions.select_default(prompt_bufnr)
      end)
      -- 絞り込んだファイルをすべて開く（Ctrl-a）
      map("i", "<C-a>", open_all_filtered)
      map("n", "<C-a>", open_all_filtered)
      return true
    end,
  })
end, { desc = "Telescope Files (vertical)" })
