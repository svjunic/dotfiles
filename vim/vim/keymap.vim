"" カラースキーム、全角表示その他
" MULTIByte Space Highlight
hi ZenkakuSpace cterm=reverse gui=reverse
match ZenkakuSpace /　/

" tab highlight
"set listchars=tab:\ \
set listchars=tab:\ \|

" The Usual
hi CurlyBracket guifg=#00bfff
match CurlyBracket /[{}]/

""" 基本形
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
