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
