"Last Change: 07-Jan-2014."

" ******************************************
" Personal Settings ************************

" カラー設定
colorscheme radicalgoodspeed

" 透過設定
if has('win32')
	set transparency=240
elseif has('mac')
	set transparency=14
elseif has('xfontset')
	set transparency=7
endif

" ウィンドウ、フォント設定
set lines=90
set columns=300
set guifont=Ayuthaya:h11
