" ハイライトの追加
autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\|NOTE\|INFO\|IDEA\)')

" ファイルタイプ識別
autocmd FileType html,jade,css,scss,sass,vue,typescript,typescriptreact,javascript,javascriptreact,astro EmmetInstall

autocmd BufRead,BufNewFile *.scss set filetype=scss
autocmd BufRead,BufNewFile *.sass set filetype=scss
autocmd BufRead,BufNewFile *.styl set filetype=stylus
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.js,*.mjs,*.cjs,*.jsx set filetype=javascript
autocmd BufRead,BufNewFile *.vue set filetype=vue
autocmd BufRead,BufNewFile *.pug set filetype=pug
autocmd BufRead,BufNewFile *.astro set filetype=astro

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

" augroup prettier
"   autocmd!
"   autocmd BufWritePre *.astro lua vim.lsp.buf.format()
" augroup END

" tsxがts判定になるのを防ぐ
autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1

" jsonc対応
autocmd FileType json syntax match Comment +\/\/.\+$+

" jsonをjsoncとして開きたい
autocmd BufRead,BufNewFile *.json set filetype=jsonc

" 特定のファイルタイプだけcopilot.vimを有効にする
autocmd FileType javascript let g:copilot_filetypes.javascript = v:true
autocmd FileType typescript let g:copilot_filetypes.typescript = v:true
autocmd FileType scss       let g:copilot_filetypes.scss       = v:true
autocmd FileType css        let g:copilot_filetypes.css        = v:true
autocmd FileType html       let g:copilot_filetypes.html       = v:true
autocmd FileType pug        let g:copilot_filetypes.pug        = v:true
autocmd FileType json       let g:copilot_filetypes.json       = v:true
autocmd FileType astro      let g:copilot_filetypes.astro      = v:true
