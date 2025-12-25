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
"set runtimepath+=~/.cache/dein/repos/github.com/CopilotC-Nvim/CopilotChat.nvim
"set runtimepath+=~/.cache/dein/repos/github.com/nvim-tree/nvim-web-devicons


let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endif


source ~/.vim/dein.vim
source ~/.vim/ddu.vim
source ~/.vim/base.vim
source ~/.vim/keymap.vim
source ~/.vim/auto.vim

lua << EOF
--require'copilot_chat_config.init'
---- require'nvim-web-devicons_config.init'
--require'other.copilot_chat_buffer_tag'
EOF
