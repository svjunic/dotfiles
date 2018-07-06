"" 起動時に有効化
"call deoplete#enable()

" 上記で動かないので、原因わかるまでの暫定対応
autocmd VimEnter * call deoplete#enable()
