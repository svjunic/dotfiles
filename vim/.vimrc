"Last Change: 20-Oct-2014."


" for linux
command! -nargs=0 CdCurrent cd %:p:h

" undofile(.un~)ファイルを作らないように変更
set noundofile

" ハイライト確認用
function! _VimColorTest()
	so $VIMRUNTIME/syntax/colortest.vim
endfunction
map <leader>vc :call _VimColorTest()<cr>

function! _VimHighliteColorTest()
	so $VIMRUNTIME/syntax/hitest.vim
endfunction
map <leader>vhc :call _VimHighliteColorTest()<cr>

" Irregular keymap
map ˜ ~


" Tab関連
" gt,gTでもいいけど
nmap tn :tabnext<cr>
nmap tp :tabprevious<cr>
nmap te :tabedit<cr>
nmap tf :tabfirst<cr>
nmap tl :tablast<cr>

"" for hl_matchit
let g:hl_matchit_enable_on_vim_startup = 1
let g:hl_matchit_hl_groupname = 'Title'
let g:hl_matchit_allow_ft_regexp = 'html\|vim\|ruby\|sh'

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
call SetInit()

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
call ToolbarToggle()

" :CopyCmdOutput
func! s:func_copy_cmd_output(cmd)
	redir @*>
	silent execute a:cmd
	redir END
endfunc
command! -nargs=1 -complete=command CopyCmdOutput call <SID>func_copy_cmd_output(<q-args>)

" 全部乗せ
nnoremap <silent> ,cr :ChromeReload<CR>

"" set clipboard=unnamed
"" nnoremap <D-c> :!pbcopy;pbpaste<CR>


autocmd BufRead,BufNewFile *.scss set filetype=scss.css
autocmd BufRead,BufNewFile *.sass set filetype=scss.css


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

" edit setting
set list
set nrformats-=octal
set hlsearch
set shiftwidth=4
set tabstop=4
set nobackup
set matchpairs=(:),{:},[:],<:>
set pastetoggle=<Insert>

" omni補完のウィンドウを表示しない
set completeopt=menuone
"set completeopt+=menuone

" 入力のオプションを複数行表示
set wildmode=list:longest

" 高速ターミナル接続 
set ttyfast

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
set number
set foldmethod=marker

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

" 単語とみなす文字の拡張
set isk+=@-@

"  " デフォルトテンプレートの読み込み
"  if has('win32') || has('win64')
"  	let $TEMPLATE_PATH = $VIM.'/template/'
"  else
"  	let $TEMPLATE_PATH = expand('~/.vim/template/')
"  endif
"  autocmd BufNewFile *.php 0r $TEMPLATE_PATH/php.txt
"  autocmd BufNewFile *.js  0r $TEMPLATE_PATH/javascript.txt

" ******************************************
" vimgrep   ********************************
nnoremap cp :cprevious<CR>zz   "前へ
nnoremap cn :cnext<CR>zz       " 次へ
nnoremap cf :<C-u>cfirst<CR>zz " 最初へ
nnoremap cl :<C-u>clast<CR>zz  " 最後へ

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

" アウトライン一覧
nnoremap <silent> ,uo :Unite outline<CR>

" Unite line 個人設定
nnoremap <silent> ,ulb :Unite line -input=Backbone.*extend<CR>
nnoremap <silent> ,ulf :Unite line -input=function<CR>
nnoremap <silent> ,ull :Unite line<CR>
nnoremap <silent> ,ulp :Unite line<CR>
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



" ******************************************
" neocomplcache.vim ************************

"NeoComplCacheEnable
let g:neocomplcache_enable_at_startup = 1

" Enable omni completion.
autocmd FileType css,scss,sass setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" 通常のオムニ補完無効
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
" パターンに引っかかったやつだけ使用
"let g:neocomplcache_omni_patterns['scss'] = ''
"let g:neocomplcache_omni_patterns['sass'] = ''


let g:neocomplcache_enable_auto_close_preview = 0

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
" let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_underbar_completion = 0

"" ファイルタイプ毎にdictファイルを設定
"let g:neocomplcache_dictionary_filetype_lists = {
"    \ 'default'    : '',
"    \ 'perl'       : $HOME . '/.vim/dict/perl.dict'
"    \ }


inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

"    " Recommended key-mappings.
"    " <CR>: close popup and save indent.
"    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"    function! s:my_cr_function()
"      return neocomplcache#smart_close_popup() . "\<CR>"
"    endfunction
"    " <TAB>: completion.
"    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"    " <C-h>, <BS>: close popup and delete backword char.
"    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"    inoremap <expr><C-y>  neocomplcache#close_popup()
"    inoremap <expr><C-e>  neocomplcache#cancel_popup()





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
let s:neosnippet_directorys = [ '~/.vim/bundle/vim-snippets/snippets', '~/.vim/bundle/1398610', '~/.vim/bundle/svjunic-snip/snippets' ]
let g:neosnippet#snippets_directory = join( s:neosnippet_directorys, ',' )




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
" othree/html5.vim *********************************
"Disable event-handler attributes support:
let g:html5_event_handler_attributes_complete = 0

"Disable RDFa attributes support:
let g:html5_rdfa_attributes_complete = 0

"Disable microdata attributes support:
let g:html5_microdata_attributes_complete = 0

"Disable WAI-ARIA attribute support:
let g:html5_aria_attributes_complete = 0



" ******************************************
" vim-ref.vim ******************************
"lynx.cfg の絶対パス
"Macはbrew install lynx でOK
"/usr/local/Cellar/lynx/2.8.7/etc/lynx.cfg
"      445 #CHARACTER_SET:iso-8859-1
"追記）446 CHARACTER_SET:utf-8
"      599 #PREFERRED_LANGUAGE:en
"追記）600 PREFERRED_LANGUAGE:ja
"" let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
"" let g:ref_alc_cmd = 'lynx -dump -nonumbers %s'
"" let g:ref_alc_start_linenumber = 47 " 開いたときの初期カーソル位置
"" let g:ref_alc_encoding = 'Shift-JIS' " 文字化けするならここで文字コードを指定してみる
"" nmap ,ra :<C-u>Ref alc<Space>

"" let g:ref_use_vimproc = 1 



" ******************************************
" YankRing.vim *****************************
if has('win32')
	let g:yankring_history_dir = expand('$HOME')
	let g:yankring_history_file = 'yankring_history'
elseif has('mac')
	let g:yankring_history_dir = '~/.vim'
	let g:yankring_history_file = 'yankring_history'
elseif has('xfontset')
endif

" filetype plugin
filetype plugin on


" ******************************************
" indent-guides ****************************
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
set ts=2 sw=2 et
set expandtab

let g:indent_guides_auto_colors = 0

" html開くとおもすぎて無理なので特定のファイルタイプだけ。
""  autocmd FileType vim,python,ruby,javascript,css,scss,sass IndentGuidesEnable
""  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234 guibg=#111111
""  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=53  guibg=#262143



" ******************************************
" syntastic.vim ****************************
" jshintを入れる必要あり( npm install -g jshint )
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



" ******************************************
" coffee-syntax-script.vim *****************
" coffeeで書き出されたjs見る用
map <leader>cw :CoffeeWatch vert<cr>


" ******************************************
" plasticboy/vim-markdown ******************
au BufRead,BufNewFile *.md set filetype=markdown


" ******************************************
" vimshell.vim ********************************
" 開いているバッファのディレクトリに移動してシェルに入る用
nnoremap <silent> ,sh :call OpenVimShell()<CR>
function! OpenVimShell()
  CdCurrent
  VimShellCurrentDir -popup
endfunction


" ******************************************
" Highlight Override Settings **************


" MULTIByte Space Highlight
hi ZenkakuSpace cterm=reverse gui=reverse
match ZenkakuSpace /　/

" tab highlight
set listchars=tab:\ \ 

" The Usual
hi CurlyBracket guifg=#00bfff
match CurlyBracket /[{}]/
