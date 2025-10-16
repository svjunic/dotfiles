"Last Change: 2020-10-20"

"                     __             .__
"  ________  __      |__|__ __  ____ |__| ____
"  /  ___|  \/ /      |  |  |  \/    \|  |/ ___\
"  \___ \ \   /       |  |  |  /   |  \  \  \___
" /____  > \_/ /\ /\__|  |____/|___|  /__|\___  >
"      \/      \/ \______|          \/        \/
"              .__
"        ___  _|__| ____________  ____
"        \  \/ /  |/     \_  __ \/ ___\
"         \   /|  |  Y Y  \  | \|  \___
"       /\ \_/ |__|__|_|  /__|   \___  >
"       \/              \/           \/

" {{{ Origin Code
" 各環境でvimscriptで何かする時用
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" :CopyCmdOutput
" }}}

set runtimepath+=~/.vim
set runtimepath+=~/.cache/dein/repos/github.com/CopilotC-Nvim/CopilotChat.nvim
set runtimepath+=~/.cache/dein/repos/github.com/nvim-tree/nvim-web-devicons

source ~/.vim/dein.vim
source ~/.vim/ddu.vim
source ~/.vim/base.vim
source ~/.vim/keymap.vim
source ~/.vim/auto.vim

lua << EOF
require'nvim-tree.init'
require'treesitter_config.init'
require'copilot_chat_config.init'
require'telescope_config.init'
require'nvim-web-devicons_config.init'
--require'lsp.tailwindcss'
require'lsp.astro'
EOF

" lua << EOF
"  vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#00ff00", bg = "#ff0000" })
" EOF
