""" vundle
set nocompatible
filetype off
if has('win32') || has('win64')
	set rtp+=$VIM/vimfiles/vundle/
	let $PLUGIN_PATH = $VIM.'/vimfiles/bundle'
else
	set rtp+=~/.vim/vundle.git/
	let $PLUGIN_PATH = expand('~/.vim/bundle')
endif
call vundle#rc($PLUGIN_PATH)


"Plugin Installing
Bundle 'Shougo/neocomplcache'
Bundle 'unite.vim'
Bundle 'surround.vim'
Bundle 'mattn/zencoding-vim'
Bundle 'SQLUtilities'
filetype plugin indent on
