"Last Change: 23-Jun-2013."

" ******************************************
" Personal Setting *************************

"" ビジュアルモードで選択したテキストがクリップボードにコピーされる設定
set clipboard+=autoselect

" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

" svjunic color
syntax on

colorscheme darkblue

set cursorline
" set cursorcolumn
hi Comment ctermfg=103
"hi CursorLine    term=underline cterm=underline ctermbg=16 guibg=236
hi CursorLine term=none cterm=none ctermbg=17 guibg=236
" hi CursorColumn  term=reverse ctermbg=7 guibg=236

