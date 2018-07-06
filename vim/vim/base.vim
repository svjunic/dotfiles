syntax on

colorscheme radicalgoodspeed

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
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932
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

" 検索のハイライト外す
nmap <C-l> <C-l>:nohlsearch<CR>
