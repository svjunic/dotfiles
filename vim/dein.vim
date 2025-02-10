let g:denops#deno = expand('~/.deno/bin/deno')

let s:dein_dir = expand('~/.cache/dein')

let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath+=' .. s:dein_src

let g:toml_dir     = expand('~/.vim/toml')
let s:toml_general = g:toml_dir . '/general.toml'
let s:toml         = g:toml_dir . '/plugins.toml'
let s:toml_svjunic = g:toml_dir . '/plugins.svjunic.toml'
let s:toml_ddu     = g:toml_dir . '/plugins.ddu.toml'
let s:toml_lazy    = g:toml_dir . '/plugins_lazy.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml_general , {'lazy': 0})

  call dein#load_toml(s:toml         , {'lazy': 0})
  call dein#load_toml(s:toml_svjunic , {'lazy': 0})
  call dein#load_toml(s:toml_ddu,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy,     {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif


call ddu#start({
  \ 'sources': [
    \ { 'name': 'file' },
    \ ],
  \ })

if !exists('g:ddu#start')
  let g:ddu#start = 0
endif
