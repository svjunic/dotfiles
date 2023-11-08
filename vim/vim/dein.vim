if &compatible
 set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

let s:dein_dir = expand('~/.cache/dein')
let g:toml_dir    = expand('~/.vim/toml')
let s:toml      = g:toml_dir . '/plugins.toml'
let s:toml_lazy = g:toml_dir . '/plugins_lazy.toml'

let s:toml_coc      = g:toml_dir . '/plugins.coc.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  "if has('nvim')
  "  call dein#add('nvim-treesitter/nvim-treesitter', { 'merged': 0 })
  "endif

  " 参考： https://qiita.com/delphinus/items/cd221a450fd23506e81a
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:toml_coc,  {'lazy': 1})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
