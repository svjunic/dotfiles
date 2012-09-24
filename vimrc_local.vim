""" vundle
set nocompatible
filetype off
if has('win32') || has('win64')
	set rtp+=$VIM/vimfiles/bundle/vundle/
	let $PLUGIN_PATH = $VIM.'/vimfiles/bundle'
else
	set rtp+=~/.vim/vundle.git/
	let $PLUGIN_PATH = expand('~/.vim/bundle')
endif
call vundle#rc($PLUGIN_PATH)


"Plugin Installing
Bundle 'Shougo/neocomplcache'
Bundle 'git://github.com/Shougo/neocomplcache-snippets-complete.git'
Bundle 'unite.vim'
Bundle 'surround.vim'
Bundle 'mattn/zencoding-vim'
Bundle 'SQLUtilities'
filetype plugin indent on


"" netrw setting
let g:netrw_liststyle = 3
" v でvsp
let g:netrw_altv = 1
" o で下
let g:netrw_alto = 1

let g:netrw_localmkdir   = "mkdir"
let g:netrw_localrmdir   = "rmdir"
let g:netrw_localcopycmd = "copy"
let g:netrw_localmovecmd = "move"

"if !executable(g:netrw_localmkdir)
"	echo "kore"
"endif
