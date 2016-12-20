"Last Change: 20-Dec-2016."

"                     __             .__
"  ________  __      |__|__ __  ____ |__| ____
"  /  ___|  \/ /      |  |  |  \/    \|  |/ ___\
"  \___ \ \   /       |  |  |  /   |  \  \  \___
" /____  > \_/ /\ /\__|  |____/|___|  /__|\___  >
"      \/      \/ \______|          \/        \/
"              .__
"        ___  _|__| ____________  ____
"        \  \/ /  |/     \_  __ \/ ___\
"         \   /|  |  Y Y  \  | \|  \___
"       /\ \_/ |__|__|_|  /__|   \___  >
"       \/              \/           \/


" {{{ base set

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
" }}}

" {{{ NeoBundle

set nocompatible
filetype off
""rtp は runtimepath
if has('win32') || has('win64')
  set rtp+=$VIM/vimfiles/bundle/neobundle.vim
  let $PLUGIN_PATH = $VIM.'/vimfiles/bundle/'
else
  set rtp+=~/.vim/bundle/neobundle.vim
  set rtp+=~/.vim/bundle/vimproc.vim
  let $PLUGIN_PATH = expand('~/.vim/bundle/')
endif
call neobundle#begin(expand($PLUGIN_PATH))
NeoBundleFetch 'Shougo/neobundle.vim'


"Plugin Installing
NeoBundle 'gh:Shougo/neocomplete'
NeoBundle 'gh:Shougo/neomru.vim'
NeoBundle 'gh:Shougo/neosnippet.vim'
NeoBundle "gh:Shougo/neosnippet-snippets"
"NeoBundle 'gh:honza/vim-snippets'
NeoBundle 'gh:svjunic/svjunic-snip'

NeoBundle 'Shougo/unite.vim', {
      \     'mac' : 'brew install the_silver_searcher',
      \     'linux' : 'apt-get install software-properties-common # (if required) && apt-add-repository ppa:mizuno-as/silversearcher-ag && apt-get update && apt-get install silversearcher-ag',
      \}

NeoBundle 'ujihisa/unite-locate'
NeoBundle 'Shougo/unite-outline'

NeoBundle 'surround.vim'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \   },
      \ }

" utility
NeoBundle 'scrooloose/syntastic', {
      \   'build': {
      \     'others': 'npm install -g eslint && npm install -g jshint'
      \   }
      \ }

" frontend
NeoBundle 'gh:mattn/emmet-vim'
NeoBundle 'kchmck/vim-coffee-script'
"NeoBundle 'ternjs/tern_for_vim', {
"  \ 'build': {
"  \   'others': 'npm install'
"  \}}
NeoBundleLazy 'ternjs/tern_for_vim', {
  \ 'autoload' : {
  \   'filetypes' : 'javascript',
  \ },
  \ 'build': {
  \   'others': 'npm install'
  \}}

"NeoBundleLazy 'gh:marijnh/tern_for_vim.git', {
"      \ 'disabled' : !has('python'),
"      \ 'autoload' : {
"      \   'filetypes' : 'javascript',
"      \ },
"      \ 'build' : 'npm install',
"      \ }

" ColorScheme
NeoBundle 'gh:svjunic/RadicalGoodSpeed.vim'


call neobundle#end()
NeoBundleCheck
filetype plugin indent on
" }}}

" {{{ pulgins setting

" {{{ matchit.vim
source $VIMRUNTIME/macros/matchit.vim
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft_regexp = 'html\|vim\|ruby\|sh'
" }}}

"" {{{ unite.vim
nmap ,u [unite]

" 入力モードで開始する
"let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

" アウトライン一覧
nnoremap <silent> [unite]uo :Unite outline<CR>

" unite grep
noremap <silent> [unite]g :Unite grep<CR>

" Unite line 個人設定
nnoremap <silent> [unite]lb :Unite line -input=Backbone.*extend<CR>
nnoremap <silent> [unite]lf :Unite line -input=function<CR>
nnoremap <silent> [unite]ll :Unite line<CR>
nnoremap <silent> [unite]lp :Unite line<CR>
nnoremap <silent> [unite]ms :Unite mapping source<CR>

nnoremap <silent> ,ums :Unite mapping source<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" NOTE: http://qiita.com/0829/items/7053b6e3371592e4fbe6
" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" NOTE: http://blog.monochromegane.com/blog/2014/01/16/the-platinum-searcher/
" PTコマンド使う
" nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" if executable('pt')
"   let g:unite_source_grep_command = 'pt'
"   let g:unite_source_grep_default_opts = '--nogroup --nocolor'
"   let g:unite_source_grep_recursive_opt = ''
" endif

"" }}}

"" {{{ neocomplete.vim

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <expr><CR>   pumvisible() ? "\<C-n>" . neocomplete#close_popup()  : "<CR>"

" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Close popup by <Space>.
" inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

"" }}}

"" {{{ neosnippet.vim

"" デフォルトスニペット無効
"let g:neosnippet#disable_runtime_snippets = { '_' : 1 }

"control+k でスニペット展開
imap <C-k>    <Plug>(neosnippet_expand_or_jump)
smap <C-k>    <Plug>(neosnippet_expand_or_jump)
xmap <C-k>    <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" json等編集時にじゃまになったので、一旦無効
"" For snippet_complete marker.
"if has('conceal')
"  set conceallevel=2 concealcursor=i
"endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let s:neosnippet_directorys = [ '~/.vim/bundle/vim-snippets/snippets', '~/.vim/bundle/1398610', '~/.vim/bundle/svjunic-snip/snippets' ]
let g:neosnippet#snippets_directory = join( s:neosnippet_directorys, ',' )
"" }}}

"" {{{ netrw.vim
let g:netrw_use_errorwindow = 1
let g:netrw_liststyle       = 4
"" }}}


"" {{{ emmet.vim
" 画像の縦横取得するときにPerlのImage::Info使っているので入ってないと動かない
" perl -MImage::Info -e ''
" これで確認
" 入っていれば何も表示されないし、入っていなければlocateにないぜっていわれる。
" cpan Image::Info
let g:user_emmet_settings = {
      \ 'variables': {
      \ 'lang' : 'ja'
      \ }
      \}

"c-kがneosnippetとかぶっていて変な動きになっていた模様
"これで一旦様子見る
let g:user_emmet_leader_key='<C-E>'
imap <C-L>    <C-E>,
vmap <C-L>    <C-E>,

" 全部のモードで動く
let g:user_emmet_mode='a'

let g:user_emmet_install_global = 0
"" }}}

"" {{{ tern_for_vim
let g:tern_map_keys=1
let g:tern#is_show_argument_hints_enabled=1
" }}}

" {{{ vimshell.vim
" 開いているバッファのディレクトリに移動してシェルに入る用
nnoremap <silent> ,sh :call OpenVimShell()<CR>
function! OpenVimShell()
  CdCurrent
  VimShellCurrentDir -popup
endfunction
" }}}

" {{{ coffee-syntax-script.vim
" coffeeで書き出されたjs見る用
map <leader>cw :CoffeeWatch vert<cr>
" }}}

" {{{ syntastic.vim
" jshintを入れる必要あり( npm install -g jshint )
" eshintを入れる必要あり( npm install -g eslint )
let g:syntastic_check_on_open = 0    "ファイルを開いたときはチェックしない
let g:syntastic_check_on_wq = 1      "保存時にはチェック
let g:syntastic_auto_loc_list = 2    "エラーがあったら自動でロケーションリストを開く（0:自動で閉じない、1:自動で開いたり閉じたり、2:そもそも開かない）
let g:syntastic_loc_list_height = 6  "エラー表示ウィンドウの高さ
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['ruby', 'javascript'],
      \ 'passive_filetypes': []
      \ }
"エラー表示マークを変更
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_enable_highlighting = 1

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

"set statusline += %#warningmsg#      "エラーメッセージの書式
"set statusline += %{SyntasticStatuslineFlag()}
"set statusline += %*
"let g:syntastic_javascript_checker = 'jshint' "jshintを使う（これはデフォルトで設定されている）
let g:syntastic_javascript_checkers = ['eslint','jshint','gjslint']

" }}}

" {{{ autogroup & autocmd

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

" {{{ keymaps setting and view settings
"" {{{ カラースキーム、全角表示その他
colorscheme radicalgoodspeed
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

" Font
if has('win32')
  set guifont=MS_Gothic:h10:cSHIFTJIS
elseif has('mac')
  set guifont=Ayuthaya:h11
elseif has('xfontset')
  set guifontset=a14,r14,k14
endif

" 各環境用設定
if has('win32')
  " Windows
  if &guioptions == 'egrLtTm'
    " GUI用
    set lines=90
    set columns=300
    set guioptions+=T
    set guioptions+=m
  else
    set guioptions-=T
    set guioptions-=m
  endif
elseif has('mac')
  set lines=90
  set columns=300
endif
" }}}

" {{{ other functions
" 各環境でvimscriptで何かする時用

" :CopyCmdOutput
func! s:func_copy_cmd_output(cmd)
  redir @*>
  silent execute a:cmd
  redir END
endfunc
command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)
" }}}
" }}}

" {{{ Origin Code
" 各環境でvimscriptで何かする時用
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
" :CopyCmdOutput
" }}}


