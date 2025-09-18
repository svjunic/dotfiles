" ハイライトの追加
autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\|NOTE\|INFO\|IDEA\)')

autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('LogNormal', '\W\zs\[\(INFO\|DEBUG\|TRACE\)\]')
autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('LogWarn', '\W\zs\[\(WARN\)\]')
autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('LogError', '\W\zs\[\(ERROR\)\]')
autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('LogFatal', '\W\zs\[\(FATAL\)\]')

autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('LogNormal', '\(INFO\|DEBUG\|TRACE\)')
autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('LogWarn', '\(WARN\)')
autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('LogError', '\(ERROR\)')
autocmd WinEnter,WinLeave,BufRead,BufNew,Syntax * call matchadd('LogFatal', '\(FATAL\)')


hi LogNormal        ctermfg=155 ctermbg=57  cterm=underline
hi LogWarn          ctermfg=186 ctermbg=0   cterm=bold,underline
hi LogError         ctermfg=164 ctermbg=0   cterm=bold,underline
hi LogFatal         ctermfg=160 ctermbg=0   cterm=bold,underline

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

" scssのときだけリロードの確認を頻繁に行う
augroup scss
  autocmd!
  autocmd BufRead,BufNewFile *.scss set autoread
  autocmd CursorMoved,CursorMovedI *.scss checktime
augroup END

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
autocmd FileType gitcommit  let g:copilot_filetypes.gitcommit  = v:true

" Git Commit メッセージ
autocmd FileType gitcommit CopilotChatK2Commit
