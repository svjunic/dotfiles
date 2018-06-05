" ファイルタイプ識別
autocmd FileType html,jade,css,scss,sass EmmetInstall
autocmd BufRead,BufNewFile *.jax set conceallevel=2

autocmd BufRead,BufNewFile *.scss set filetype=scss.css
autocmd BufRead,BufNewFile *.sass set filetype=scss.css
autocmd BufRead,BufNewFile *.md set filetype=markdown

" htmlのとじタグを</でいれる
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END
" }}}
