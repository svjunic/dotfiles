vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

vim.g.maplocalleader = "\\"

-- base.vim 相当
vim.opt.undofile = false
vim.opt.ignorecase = true
vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest", "full" }
vim.opt.history = 10000
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 15
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.iskeyword:append("@-@")
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.list = true
vim.opt.nrformats:remove("octal")
vim.opt.hlsearch = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.statusline = "%<%F %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l, [TYPE=%Y] [ASCII=\\%03.3b] [HEX=\\%02.2B] %c%V%8P"

vim.opt.fileencodings = { "ucs-bom", "utf-8", "cp932", "iso-2022-jp", "euc-jp" }
vim.opt.fileformat = "unix"
vim.opt.fileformats = { "unix", "dos" }

vim.opt.foldmethod = "marker"
vim.opt.number = true
vim.opt.expandtab = true

vim.opt.conceallevel = 0
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.spelllang = { "en", "cjk" }
vim.opt.synmaxcol = 1000
vim.opt.tags = "./tags;$HOME"

-- netrw（oil が使えない時のフォールバック用。oil が default_file_explorer なら基本使われません）
vim.g.netrw_liststyle = 1
vim.g.netrw_banner = 0
vim.g.netrw_sizestyle = "H"
vim.g.netrw_timefmt = "%Y/%m/%d(%a) %H:%M:%S"
vim.g.netrw_preview = 1
vim.g.netrw_altv = 1

-- base.vim 由来の便利コマンド/abbrev
vim.api.nvim_create_user_command("CdCurrent", function()
  local dir = vim.fn.expand("%:p:h")
  if dir ~= nil and dir ~= "" then
    vim.cmd.cd(dir)
  end
end, {})

vim.cmd([[
  cabbrev ws set fenc=cp932<CR>:w
  cabbrev we set fenc=euc-jisx0213<CR>:w
  cabbrev wj set fenc=iso-2022-jp-3<CR>:w
  cabbrev wu set fenc=utf-8<CR>:w

  cabbrev es e ++enc=cp932
  cabbrev ee e ++enc=euc-jisx0213
  cabbrev ej e ++enc=iso-2022-jp-3
  cabbrev eu e ++enc=utf-8
]])
