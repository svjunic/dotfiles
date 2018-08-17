" Equivalent to the above.
let g:ale_linters = {
\ 'html': ['htmlhint'],
\ 'javascript': ['eslint']
\}

" Enable completion where available.
let g:ale_completion_enabled = 1

" 保存時にpretteirをかけてeslintをする
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['prettier', 'eslint']
let g:ale_fixers.mjs = ['prettier', 'eslint']
let g:ale_fixers.jsx = ['prettier', 'eslint']
let g:ale_fixers.vue = ['prettier', 'eslint']

" 圧縮ファイルのときはなるべく動かさない
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}

" ファイル保存時に実行
function! ALE_FIX_TOGGLE()
  if !exists('g:ale_fix_on_save') || g:ale_fix_on_save == 0
    let g:ale_fix_on_save = 1
  else 
    let g:ale_fix_on_save = 0
  endif
endfunction
call ALE_FIX_TOGGLE()

" 変更されてからlint実行までのdelay
let g:ale_lint_delay=10

"" ステータスバーの表示
"let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

" ローカルの設定ファイルを考慮する
let g:ale_javascript_prettier_use_local_config = 1

" エラー行の表示部分を常に表示する
let g:ale_sign_column_always = 1

" ctrl+j/kでエラー行に移動
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
