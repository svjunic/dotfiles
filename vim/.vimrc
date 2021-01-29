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

source ~/.vim/vim/dein.vim
source ~/.vim/vim/base.vim
source ~/.vim/vim/keymap.vim
source ~/.vim/vim/auto.vim
