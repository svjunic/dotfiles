"Last Change: 08-Aug-2013."

" ******************************************
" ******************************************
" Personal Settings ************************

" テスト
function! NormalMode()
	set lines=90
	set columns=300
	set guifont=Ayuthaya:h11
endfunction
map <leader>n :call NormalMode()<cr>

" テスト 2
function! SuperMode()
	set lines=100
	set columns=300
	set guifont=Zapfino:h11
endfunction
map <leader>s :call SuperMode()<cr>

" ハイライト確認用
function! _VimColorTest()
	so $VIMRUNTIME/syntax/colortest.vim
endfunction
map <leader>vc :call _VimColorTest()<cr>

function! _VimHighliteColorTest()
	so $VIMRUNTIME/syntax/hitest.vim
endfunction
map <leader>vhc :call _VimHighliteColorTest()<cr>

" Font
function! SetInit()
	if has('win32')
		" Windows
		set lines=90
		set columns=300
		set guifont=MS_Gothic:h10:cSHIFTJIS
	elseif has('mac')
		set lines=90
		set columns=300
		set guifont=Ayuthaya:h11
	elseif has('xfontset')
		" UNIX用 (xfontsetを使用)
		set guifontset=a14,r14,k14
	endif

endfunction!

call SetInit()<cr>

function! ToolbarToggle()
	if &guioptions == 'egrLtTm'
		"l:ll = str2nr(&lines,10)-2
		"l:cc = str2nr(&columns,10)-2
		"&lines   = l:ll
		"&columns = l:cc
		set lines=90
		set columns=300
		set guioptions+=T
		set guioptions+=m
	else
		set guioptions-=T
		set guioptions-=m
	endif
endfunction
map <leader>t :call ToolbarToggle()<cr>
call ToolbarToggle()<cr>
"set guioptions-=T
"set guioptions-=m

"" " mac用の記述しないと・・・
"" " Open URL - Firefox firefox.exe -new-tab
"" function! HandleURL()
"" 	let s:uri = matchstr(getline("."), '[a-z]*://[^ >,;]*')
"" 	if s:uri != ""
"" 		"let path = "C:/Program Files/Mozilla Firefox/"
"" 		"exec 'silent !"' . path . 'firefox.exe" -new-tab ' . s:uri
"" 	else
"" 		exec 'silent !open -a Google\ Chrome ' . url
"" 	endif
"" endfunction
"" " \u で実行
"" map <leader>u :call HandleURL()<cr>
"" 
"" " mac用の記述しないと・・・
"" " Search Keyword - firefox.exe -new-tab google-search-url
"" function! Google()
"" 	let keyword = expand("<cword>")
"" 	let keyword = matchstr(getline("."), '[a-z]*://[^ >,;]*')
"" 	let url = "http://www.google.com/search?q=" . keyword
"" 	"let path = "C:/Program Files/Mozilla Firefox/"
"" 	"exec 'silent !"' . path . 'firefox.exe" -new-tab ' . url
"" 	exec 'silent !open -a Google\ Chrome ' . url
"" endfun
"" " \g で実行
"" nmap <leader>g :call Google()<CR>


" :CopyCmdOutput
func! s:func_copy_cmd_output(cmd)
	redir @*>
	silent execute a:cmd
	redir END
endfunc
command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)

" 全部乗せ
nnoremap <silent> ,cr :ChromeReload<CR>


autocmd css FileType call g:setPreviewCSSColorInLine()


" ******************************************
" Minor settings ***************************
" カラー設定
colorscheme radicalgoodspeed

" Windows
if has('win32')
	" Insert : copy
	map <Insert> "+y

	" Shift-Insert : paste
	map <S-Insert> "+gP
	imap <S-Insert> <C-R>+
endif

" Ctrl-L で検索ハイライトを消す
nmap <C-l> <C-l>:nohlsearch<CR>

" syntax on
set list
set nrformats-=octal
set hlsearch
set shiftwidth=4
set tabstop=4
set nobackup
set matchpairs=(:),{:},[:],<:>
set pastetoggle=<Insert>

" ステータスラインの設定
set cmdheight=1
set laststatus=2
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ %c%V%8P
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
set number

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

" ウィンドウに1行で収まらない場合、ウィンドウ上では自動改行を行って表示しない
set nowrap

" デフォルトテンプレートの読み込み
if has('win32') || has('win64')
	let $TEMPLATE_PATH = $VIM.'/template/'
else
	let $TEMPLATE_PATH = expand('~/.vim/template/')
endif
autocmd BufNewFile *.php 0r $TEMPLATE_PATH/php.txt
autocmd BufNewFile *.js  0r $TEMPLATE_PATH/javascript.txt


" ******************************************
" ******************************************
" Plugin Settings **************************



" ******************************************
" unite.vim ********************************
" 入力モードで開始する
"let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q




" ******************************************
" neocomplcache.vim ************************
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化
NeoComplCacheEnable

"" キャッシュする文字列の長さの最小値（デフォルト値4）
let g:neocomplcache_min_syntax_length = 3

"" 大文字が入力さた場合、限り大文字小文字の区別をする
let g:neocomplcache_enable_smart_case = 1

" キャメルケースの候補展開
" 0:無効
" 1:有効
" 例）DooDooo -> DD
let g:neocomplcache_enable_camel_case_completion = 1

" アンダースコアの候補展開
" 0:無効
" 1:有効
" 例）n_e_u_c -> neocomplcache_enable_underbar_completion
let g:neocomplcache_enable_underbar_completion = 1

"" ファイルタイプ毎にdictファイルを設定
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default'    : '',
"    \ 'perl'       : $HOME . '/.vim/dict/perl.dict'
"    \ }




" ******************************************
" neosnippet.vim ***************************
"control+l でスニペット展開
imap <C-l>    <Plug>(neosnippet_expand_or_jump)
smap <C-l>    <Plug>(neosnippet_expand_or_jump)
xmap <C-l>    <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'




" ******************************************
" netrw.vim ********************************
let g:netrw_use_errorwindow = 1
let g:netrw_liststyle       = 4




" ******************************************
" TweetVim *********************************
let g:tweetvim_tweet_per_page = 100
let g:tweetvim_cache_size     = 100
let g:tweetvim_include_rts    = 1
let g:tweetvim_display_source = 1

nnoremap <silent> ,th :<C-u>TweetVimHomeTimeline<CR>



" ******************************************
" vim-ref.vim ******************************
"lynx.cfg の絶対パス
"Macはbrew install lynx でOK
"/usr/local/Cellar/lynx/2.8.7/etc/lynx.cfg
"      445 #CHARACTER_SET:iso-8859-1
"追記）446 CHARACTER_SET:utf-8
"      599 #PREFERRED_LANGUAGE:en
"追記）600 PREFERRED_LANGUAGE:ja
let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
let g:ref_alc_start_linenumber = 47 " 開いたときの初期カーソル位置
"let g:ref_alc_encoding = 'Shift-JIS' " 文字化けするならここで文字コードを指定してみる
nmap ,ra :<C-u>Ref alc<Space>

let g:ref_use_vimproc = 1 

" YankRing.vim
if has('win32')
  let g:yankringt_history_dir = expand('$HOME')
  let g:yankringt_history_file = '.yankring_history'
elseif has('mac')
  let g:yankringt_history_dir = expand('~/.vim/')
  let g:yankringt_history_file = '.yankring_history'
elseif has('xfontset')
endif

" filetype plugin
filetype plugin on




" ******************************************
" syntastic.vim ****************************
" jshintを入れる必要あり( npm install -g jshint )
let g:syntastic_check_on_open = 0    "ファイルを開いたときはチェックしない
let g:syntastic_check_on_wq = 0      "保存時にはチェック
let g:syntastic_auto_loc_list = 2    "エラーがあったら自動でロケーションリストを開く（0:自動で閉じない、1:自動で開いたり閉じたり、2:そもそも開かない）
let g:syntastic_loc_list_height = 6  "エラー表示ウィンドウの高さ
set statusline += %#warningmsg#      "エラーメッセージの書式
set statusline += %{SyntasticStatuslineFlag()}
set statusline += %*
"let g:syntastic_javascript_checker = 'jshint' "jshintを使う（これはデフォルトで設定されている）
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




" ******************************************
" Append Override Settings *****************

" MULTIByte Space Highlight
highlight ZenkakuSpace cterm=reverse gui=reverse
match ZenkakuSpace /　/

" tab highlight
set listchars=tab:\ \ 
highlight SpecialKey cterm=underline gui=underline

"" "" カーソル行のハイライト
"" set cursorline
"" hi clear CursorLine
"" "highlight CursorLine ctermbg=black guibg=black
"" highlight CursorLine guibg=black
"" 
"" "" 候補のプルダウンウィンドウの配色
"" hi Pmenu guibg=#666666
"" hi PmenuSel guibg=#8cd0d3 guifg=#666666
"" hi PmenuSbar guibg=#333333
"" highlight Pmenu ctermbg=4
"" highlight PmenuSel ctermbg=1
"" highlight PMenuSbar ctermbg=4
