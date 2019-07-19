" ファイルタイプ識別
autocmd FileType html,jade,css,scss,sass,vue EmmetInstall

autocmd Filetype javascript,vue ALELint

autocmd BufRead,BufNewFile *.scss set filetype=scss.css
autocmd BufRead,BufNewFile *.sass set filetype=scss.css
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.js,*.mjs,*.jsx set filetype=javascript
autocmd BufRead,BufNewFile *.vue set filetype=vue
autocmd BufRead,BufNewFile *.pug set filetype=pug

" " htmlのとじタグを</でいれる
" augroup MyXML
"   autocmd!
"   autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
"   autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
" augroup END
" }}}

" scssのときだけリロードの確認を頻繁に行う
augroup scss
  autocmd!
  autocmd BufRead,BufNewFile *.scss set autoread
  autocmd CursorMoved,CursorMovedI *.scss checktime
augroup END


