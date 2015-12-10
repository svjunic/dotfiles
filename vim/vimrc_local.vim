"Last Change: 10-Dec-2015."
"
scriptencoding utf-8

""" vundle
set nocompatible

filetype off
""rtp は runtimepath
if has('win32') || has('win64')
	set rtp+=$VIM/vimfiles/bundle/neobundle.vim
	let $PLUGIN_PATH = $VIM.'/vimfiles/bundle/'
else
	set rtp+=~/.vim/bundle/neobundle.vim
	set rtp+=~/.vim/bundle/vimproc.vim
	let $PLUGIN_PATH = expand('~/.vim/bundle/')
endif

call neobundle#begin(expand($PLUGIN_PATH))

NeoBundleFetch 'Shougo/neobundle.vim'


"Plugin Installing
"NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'gh:Shougo/neocomplcache'
NeoBundle 'gh:Shougo/neomru.vim.git'
NeoBundle 'gh:Shougo/neosnippet.vim.git'
NeoBundle "Shougo/neosnippet-snippets"
NeoBundle 'gh:honza/vim-snippets.git'
NeoBundle 'gh:svjunic/svjunic-snip.git'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-locate'
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
NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'scrooloose/syntastic.git', {
" \   'build': {
" \     'others': 'npm install -g jshint'
" \   }
" \ }
NeoBundle 'surround.vim'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'https://github.com/rbtnn/vimconsole.vim.git'
NeoBundle 'nathanaelkane/vim-indent-guides'

" front-end - html
NeoBundle 'https://github.com/othree/html5.vim.git'
NeoBundle 'https://github.com/mattn/emmet-vim.git'
NeoBundle 'gh:svjunic/scss-snippets.git'
NeoBundle 'digitaltoad/vim-jade.git'

" front-end - css
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'https://gist.github.com/1398610.git'
NeoBundle 'https://github.com/vim-scripts/hexHighlight.vim.git'

" front-end - javascript
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'marijnh/tern_for_vim', {
  \ 'build': {
  \   'others': 'npm install'
  \}}
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'clausreinke/typescript-tools'

" other - syntax
NeoBundle 'plasticboy/vim-markdown'

" utility2
NeoBundle 'SQLUtilities'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'gh:tell-k/vim-browsereload-mac.git'
NeoBundle 'basyura/TweetVim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'koron/codic-vim'
NeoBundle 'vim-scripts/Align'
NeoBundle 'cohama/agit.vim'
NeoBundle 'modsound/macdict-vim.git'

" ColorScheme
NeoBundle 'gh:svjunic/RadicalGoodSpeed.vim.git'



"NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'AtsushiM/sass-compile.vim'

"NeoBundle 'violetyk/cake.vim'
"NeoBundle 'taglist.vim'
"NeoBundle 'TwitVim'
"NeoBundle 'Shougo/vinarise'
"NeoBundle 'fugitive.vim'
"NeoBundle 'The-NERD-tree'
"NeoBundle 'The-NERD-Commenter'
"NeoBundle 'thinca/vim-localrc'
"NeoBundle 'motemen/hatena-vim'
"NeoBundle 'mattn/unite-advent_calendar'

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

filetype plugin indent on
