" aleとかぶるので基本off
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0

" normalモードでgitと打つと変化の部分トグル
nmap <silent> gitdiff :GitGutterToggle<CR>
