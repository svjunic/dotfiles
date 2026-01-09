" ハイライトの追加
" NOTE:
" - :colorscheme でハイライトが上書きされがちなので ColorScheme で再適用
" - matchadd() をイベント毎に積み増すと match の枠が埋まり「効かない」状態になりやすいので、1ウィンドウ1回だけにする

function! s:ApplyCustomHighlights() abort
  hi LogNormal        ctermfg=155 ctermbg=57  cterm=underline      guifg=#5fd7ff guibg=#005f5f gui=underline
  hi LogWarn          ctermfg=186 ctermbg=0   cterm=bold,underline guifg=#ffd700 guibg=NONE gui=bold,underline
  hi LogError         ctermfg=164 ctermbg=0   cterm=bold,underline guifg=#ff5f87 guibg=NONE gui=bold,underline
  hi LogFatal         ctermfg=160 ctermbg=0   cterm=bold,underline guifg=#ff5f00 guibg=NONE gui=bold,underline
endfunction

function! s:EnsureWindowMatches() abort
  if exists('w:custom_matchadd_ids')
    return
  endif

  let w:custom_matchadd_ids = []
  call add(w:custom_matchadd_ids, matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\|NOTE\|INFO\|IDEA\)', 200))

  call add(w:custom_matchadd_ids, matchadd('LogNormal', '\W\zs\[\(INFO\|DEBUG\|TRACE\)\]', 200))
  call add(w:custom_matchadd_ids, matchadd('LogWarn',   '\W\zs\[\(WARN\)\]', 200))
  call add(w:custom_matchadd_ids, matchadd('LogError',  '\W\zs\[\(ERROR\)\]', 200))
  call add(w:custom_matchadd_ids, matchadd('LogFatal',  '\W\zs\[\(FATAL\)\]', 200))

  call add(w:custom_matchadd_ids, matchadd('LogNormal', '\(INFO\|DEBUG\|TRACE\)', 200))
  call add(w:custom_matchadd_ids, matchadd('LogWarn',   '\(WARN\)', 200))
  call add(w:custom_matchadd_ids, matchadd('LogError',  '\(ERROR\)', 200))
  call add(w:custom_matchadd_ids, matchadd('LogFatal',  '\(FATAL\)', 200))
endfunction

augroup MyCustomHighlights
  autocmd!
  autocmd ColorScheme * call s:ApplyCustomHighlights()
  autocmd WinEnter,BufWinEnter,Syntax * call s:EnsureWindowMatches()
augroup END

call s:ApplyCustomHighlights()

" ファイルタイプ識別
autocmd FileType html,jade,css,scss,sass,vue,typescript,typescriptreact,javascript,javascriptreact,astro EmmetInstall

autocmd BufRead,BufNewFile *.scss set filetype=scss
autocmd BufRead,BufNewFile *.sass set filetype=scss
autocmd BufRead,BufNewFile *.styl set filetype=stylus
autocmd BufRead,BufNewFile *.md,*.mdx set filetype=markdown
autocmd BufRead,BufNewFile  set filetype=markdown
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
autocmd FileType gitcommit if exists(':CopilotChatK2Commit') | CopilotChatK2Commit | endif
