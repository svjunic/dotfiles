" 検索のハイライト外す
nmap <C-l> <C-l>:nohlsearch<CR>

"" カラースキーム、全角表示その他
" MULTIByte Space Highlight
function! s:ApplyKeymapHighlights() abort
  hi ZenkakuSpace cterm=reverse gui=reverse
  hi CurlyBracket guifg=#00bfff
endfunction

augroup MyKeymapHighlights
  autocmd!
  autocmd ColorScheme * call s:ApplyKeymapHighlights()
augroup END

call s:ApplyKeymapHighlights()

match ZenkakuSpace /　/

" tab highlight
set listchars=tab:\ \|

" The Usual
" match CurlyBracket /[{}]/

""" 基本形
map ˜ ~

" Buffer
nmap bn :next<cr>
nmap bp :prev<cr>

" Oil
function! s:OpenOil() abort
  " oil.nvim は Neovim 専用。Vim の場合は netrw にフォールバック。
  if !has('nvim')
    execute 'Explore'
    return
  endif

  " dein の on_cmd が効かない/ロード順が崩れた場合でも、明示的に source してから :Oil を呼ぶ。
  if exists('*dein#source')
    try
      call dein#source('stevearc/oil.nvim')
    catch
    endtry
  endif

  if exists(':Oil')
    execute 'Oil'
  else
    echoerr 'Oil command not available (plugin not installed/loaded)'
  endif
endfunction

nnoremap <silent> - :call <SID>OpenOil()<CR>

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


" ハイライト確認用
function! s:sv_set_dev_HighlightMapping()
  nnoremap <silent> <space> :TSHighlightCapturesUnderCursor<CR>
endfunction
command! SVSetDevHightlightMapping call s:sv_set_dev_HighlightMapping()
