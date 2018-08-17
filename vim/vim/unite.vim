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
