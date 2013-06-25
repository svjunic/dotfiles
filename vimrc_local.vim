""" vundle
set nocompatible
filetype off
""rtp は runtimepath
if has('win32') || has('win64')
	set rtp+=$VIM/vimfiles/bundle/neobundle.vim
	let $PLUGIN_PATH = $VIM.'/vimfiles/bundle/'
else
	set rtp+=~/.vim/bundle/neobundle.vim
	let $PLUGIN_PATH = expand('~/.vim/bundle/')
endif
call neobundle#rc($PLUGIN_PATH)


"Plugin Installing
NeoBundle 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/neocomplcache'
NeoBundle 'https://github.com/Shougo/neocomplcache.vim.git'
NeoBundle 'git://github.com/Shougo/neosnippet.vim.git'
NeoBundle 'git://github.com/honza/vim-snippets.git'


NeoBundle 'Shougo/unite.vim'
"NeoBundle 'ujihisa/unite-locate'
NeoBundle 'Shougo/unite-outline'

NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\ }

" utility
NeoBundle 'surround.vim'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'ref.vim'
NeoBundle 'thinca/vim-quickrun'

" front-end - html
NeoBundle 'mattn/zencoding-vim'
" front-end - css
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'AtsushiM/sass-compile.vim'
" front-end - javascript
NeoBundle 'hallettj/jslint.vim.git'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'jelera/vim-javascript-syntax'


" utility2
NeoBundle 'SQLUtilities'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'git://github.com/tell-k/vim-browsereload-mac.git'
"NeoBundle 'violetyk/cake.vim'
"NeoBundle 'taglist.vim'
NeoBundle 'basyura/TweetVim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/bitly.vim'
"NeoBundle 'TwitVim'
NeoBundle 'Shougo/vinarise'
"NeoBundle 'fugitive.vim'
"NeoBundle 'The-NERD-tree'
"NeoBundle 'The-NERD-Commenter'
"NeoBundle 'thinca/vim-localrc'
"NeoBundle 'motemen/hatena-vim'
"NeoBundle 'mattn/unite-advent_calendar'

filetype plugin indent on
