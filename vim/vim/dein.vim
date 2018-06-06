if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')
  call dein#add('Shougo/deoplete.nvim')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  " added plugin {{{
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/unite-outline')
  call dein#add('Shougo/neomru.vim')
  call dein#add('ujihisa/unite-locate')

  call dein#add('thinca/vim-quickrun')

  call dein#add('tpope/vim-surround')

  call dein#add('mattn/emmet-vim')

  if has('job') && has('channel') && has('timers')
    call dein#add('w0rp/ale')
  else
    call dein#add('vim-syntastic/syntastic')
  endif

  call dein#add('svjunic/RadicalGoodSpeed.vim')
  call dein#add('svjunic/svjunic-snip')
  " }}}

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

syntax enable
