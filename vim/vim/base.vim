syntax on

colorscheme radicalgoodspeed
"colorscheme snortist-theme

scriptencoding utf-8

" undofile(.un~)ファイルを作らないように変更
set noundofile

" 検索の大文字小文字を無視
set ic

" for linux
command! -nargs=0 CdCurrent cd %:p:h

" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full

" コマンドラインの履歴を10000件保存する
set history=10000

" omni補完のウィンドウを表示しない
set completeopt=menuone

" ウィンドウに1行で収まらない場合、ウィンドウ上では自動改行を行って表示しない
set nowrap

" 入力のオプションを複数行表示
set wildmode=list:longest

" インデント付きで折り返す
if (v:version == 704 && has('patch338')) || v:version >= 705
  set breakindent
endif

" 単語とみなす文字の拡張
set isk+=@-@

" エラー表示する部分を表示する
set signcolumn=yes

" swapファイルに書き込まれる時間の間隔
set updatetime=300

set list
set nrformats-=octal
set hlsearch
set shiftwidth=2
set tabstop=2
set nobackup
set nowritebackup
set matchpairs=(:),{:},[:],<:>
set pastetoggle=<Insert>

" ステータスラインの設定
set cmdheight=1
set laststatus=2
set statusline=%<%F\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ %c%V%8P

" 文字コード関連の設定
if has("win32")
  "ref.vim
  let &termencoding = &encoding
endif
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp932,iso-2022-jp,euc-jp
set fileformat=unix
set fileformats=unix,dos
set ambiwidth=double

set foldmethod=marker

set number
set expandtab

" 文字コード指定でファイルを保存
cabbrev ws set fenc=cp932<CR>:w
cabbrev we set fenc=euc-jisx0213<CR>:w
cabbrev wj set fenc=iso-2022-jp-3<CR>:w
cabbrev wu set fenc=utf-8<CR>:w

" 文字コード指定でファイルを開く
cabbrev es e ++enc=cp932
cabbrev ee e ++enc=euc-jisx0213
cabbrev ej e ++enc=iso-2022-jp-3
cabbrev eu e ++enc=utf-8

" 日本語があるときにちらつく問題
set conceallevel=0

" バックスペースが効かなくなる問題対策
set backspace=indent,eol,start

" スペルチェックから日本語を除外
set spelllang=en,cjk

" 1行が長いファイルでsyntaxで重くならないように
set synmaxcol=1000

" ctagファイルを検索
set tags=./tags;$HOME

" matcht.vimの読み込み
source $VIMRUNTIME/macros/matchit.vim
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft_regexp = 'html\|vim\|ruby\|sh'

" ntetrwの初期設定変更
" ファイルツリーの表示形式、1にするとls -laのような表示になります
let g:netrw_liststyle=1
" ヘッダを非表示にする
let g:netrw_banner=0
" サイズを(K,M,G)で表示する
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1
" vで開いたときに右に出す
let g:netrw_altv=1

" ハイライト確認用
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

"" Cocのフロートウィンドウが閉じない場合 の対応仮
"let g:node_client_debug = 1
" hook うまく動かず
" let g:coc_start_at_startup = 1 もうまく動かず
" coc起動
CocStart
