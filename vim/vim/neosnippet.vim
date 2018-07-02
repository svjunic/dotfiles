"Ctrl+Kにターゲットジャンプ割当
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"let s:neosnippet_directorys = [ '~/.cache/dein/repos/github.com/svjunic/svjunic-snip/snippets' ]
"let g:neosnippet#snippets_directory = join( s:neosnippet_directorys, ',' )
