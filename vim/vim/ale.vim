" Equivalent to the above.
let b:ale_linters = {'javascript': ['eslint']}

" Enable completion where available.
let g:ale_completion_enabled = 1

" 保存時にpretteirをかけてeslintをする
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier-eslint']
let g:ale_fixers['mjs'] = ['prettier-eslint']
let g:ale_fixers['jsx'] = ['prettier-eslint']
let g:ale_fixers['vue'] = ['prettier-eslint']

" ファイル保存時に実行
let g:ale_fix_on_save = 1

" ローカルの設定ファイルを考慮する
let g:ale_javascript_prettier_use_local_config = 1

" エラー行の表示部分を常に表示する
let g:ale_sign_column_always = 1
