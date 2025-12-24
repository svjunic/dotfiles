require("nvim-web-devicons").setup{
  override = {},
  default = true,
}

vim.api.nvim_create_autocmd('TextChanged', {
  group = vim.api.nvim_create_augroup('CopilotChatIcons', { clear = true }),
  pattern = '*',
  callback = function()
    -- 現在の行に対して、言語に応じたアイコンを表示
    local filetype = vim.bo.filetype
    local icon, _ = require('nvim-web-devicons').get_icon('test.' .. filetype)

    if icon then
      -- アイコンを表示（ここではコードブロックの前にアイコンを表示）
      vim.cmd('echo "' .. icon .. '"')
    end
  end
})
