local ok_telescope, telescope = pcall(require, 'telescope')
if not ok_telescope then
  -- ここで return すると require() によって「ロード済み」としてキャッシュされ、
  -- VimEnter での再 require が再実行されない。
  package.loaded['telescope_config.init'] = nil
  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('TelescopeConfigRetry', { clear = true }),
    once = true,
    callback = function()
      pcall(require, 'telescope_config.init')
    end,
  })
  return
end

telescope.setup{
  defaults = {
    file_ignore_patterns = { "node_modules", ".git/", ".next", ".DS_Store" },
    hidden = true,
    borderchars = {
      "─",
      "│",
      "─",
      "│",
      "╭",
      "╮",
      "╯",
      "╰"
    },
    layout_config = {
      prompt_position = "bottom",  -- プロンプトを下に配置
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
    results_height = 0.5,  -- 必要に応じて高さを調整
    preview_cutoff = 120,  -- プレビューの制限
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true,  -- .gitignore の無視設定を無視
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        borderchars = {
          "─",
          "│",
          "─",
          "│",
          "╭",
          "╮",
          "╯",
          "╰"
        },
        prompt_prefix = "🔍 ",
      }),
    }
  }
}

-- ui-select は "拡張が source された後" に load_extension しないと空振りするため、
-- VimEnter 後に一度だけ再試行して `vim.ui.select` を確実に差し替える。
vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('TelescopeUiSelectBind', { clear = true }),
  once = true,
  callback = function()
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'fzf')
    local ext = telescope.extensions and telescope.extensions['ui-select']
    if ext and type(ext.select) == 'function' then
      vim.ui.select = ext.select
    end
  end,
})
