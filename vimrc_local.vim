" Vim color file
" Maintaner: sv.junic
" Last Change: 14-Sep-2012."

" kaoriyaさんからダウンロードした状態で、vimrcにvimrc_local.vimがあればそれを
" 先読みする設定があるので、そのの設定を使います

" vundle
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
