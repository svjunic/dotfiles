" {{{ カラースキーム、全角表示その他
" MULTIByte Space Highlight
hi ZenkakuSpace cterm=reverse gui=reverse
match ZenkakuSpace /　/

" tab highlight
"set listchars=tab:\ \
set listchars=tab:\ \|

" The Usual
hi CurlyBracket guifg=#00bfff
match CurlyBracket /[{}]/
"" }}}

""" {{{ 基本形
map ˜ ~

" Tab
nmap tn :tabnext<cr>
nmap tp :tabprevious<cr>
nmap te :tabedit<cr>
nmap tf :tabfirst<cr>
nmap tl :tablast<cr>

" vimgrep
nnoremap cp :cprevious<CR>zz   "前へ
nnoremap cn :cnext<CR>zz       " 次へ
nnoremap cf :<C-u>cfirst<CR>zz " 最初へ
nnoremap cl :<C-u>clast<CR>zz  " 最後へ

" 論理行でなく表示行で移動する
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

"" Font
"if has('win32')
"  set guifont=MS_Gothic:h10:cSHIFTJIS
"elseif has('mac')
"  set guifont=Ayuthaya:h11
"elseif has('xfontset')
"  set guifontset=a14,r14,k14
"endif
"
"" 各環境用設定
"if has('win32')
"  " Windows
"  if &guioptions == 'egrLtTm'
"    " GUI用
"    set lines=90
"    set columns=300
"    set guioptions+=T
"    set guioptions+=m
"  else
"    set guioptions-=T
"    set guioptions-=m
"  endif
"elseif has('mac')
"  set lines=90
"  set columns=300
"endif
"" }}}
"
"" {{{ other functions
"" 各環境でvimscriptで何かする時用
"
"" :CopyCmdOutput
"func! s:func_copy_cmd_output(cmd)
"  redir @*>
"  silent execute a:cmd
"  redir END
"endfunc
"command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)
"" }}}
"
