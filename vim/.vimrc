"Last Change: 07-Jun-2018."

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

source ~/.vim/vim/dein.vim
source ~/.vim/vim/netrw.vim
source ~/.vim/vim/keymap.vim
source ~/.vim/vim/unite.vim
source ~/.vim/vim/ale.vim
source ~/.vim/vim/emmet.vim
source ~/.vim/vim/deoplete.vim
source ~/.vim/vim/deoplete-ternjs.vim
source ~/.vim/vim/neosnippet.vim
source ~/.vim/vim/matchit.vim
source ~/.vim/vim/match-tag-always.vim
source ~/.vim/vim/vim-fugitive.vim
source ~/.vim/vim/vim-rhubarb.vim
source ~/.vim/vim/vim-gitgutter.vim

source ~/.vim/vim/auto.vim
source ~/.vim/vim/base.vim

" {{{ Origin Code
" 各環境でvimscriptで何かする時用
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" :CopyCmdOutput
" }}}
