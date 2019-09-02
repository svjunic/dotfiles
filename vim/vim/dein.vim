if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')

  " added plugin {{{

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  "call dein#add('Shougo/vimproc.vim', {
  "      \ 'build': {
  "      \     'windows' : 'tools\\update-dll-mingw',
  "      \     'cygwin'  : 'make -f make_cygwin.mak',
  "      \     'mac'     : 'make -f make_mac.mak',
  "      \     'linux'   : 'make',
  "      \     'unix'    : 'gmake',
  "      \    },
  "      \ })
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/unite-outline')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('ujihisa/unite-locate')
  call dein#add('ternjs/tern_for_vim', { 'build':'npm install' })
  call dein#add('carlitux/deoplete-ternjs', { 'build':{ 'mac': 'npm install -g tern', 'unix': 'npm install -g tern' }, 'on_ft':['js','javascript','jsx','mjs','vue'] })
  ""call dein#add('ternjs/tern_for_vim', { 'build':'npm install' })
  ""call dein#add('carlitux/deoplete-ternjs', { 'on_ft':['js','javascript','jsx','mjs','vue'] })
  call dein#add('thinca/vim-quickrun')
  call dein#add('tpope/vim-surround')
  call dein#add('mattn/emmet-vim')
  call dein#add('posva/vim-vue')

  call dein#add('vim-scripts/YankRing.vim')
  call dein#add('vim-scripts/Align')

  call dein#add('w0rp/ale')

  " html5 syntax
  call dein#add('othree/html5.vim')

  " javascript syntax
  call dein#add('othree/yajs.vim')

  " pug syntax
  call dein#add('digitaltoad/vim-pug')

  " the highlights the enclosing html/xml tags
  call dein#add('Valloric/MatchTagAlways')
  
  " git
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('airblade/vim-gitgutter')

  call dein#add('svjunic/RadicalGoodSpeed.vim')
  call dein#add('svjunic/svjunic-snip')
  " }}}

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
