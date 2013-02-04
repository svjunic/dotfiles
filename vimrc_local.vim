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
" 1.
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet.git'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\   },
\ }
NeoBundle 'surround.vim'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'teramako/jscomplete-vim'

" 2.
NeoBundle 'ref.vim'
NeoBundle 'SQLUtilities'
NeoBundle 'git://github.com/AtsushiM/sass-compile.vim.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'open-browser.vim'
NeoBundle 'jelera/vim-javascript-syntax'

" 3.
"NeoBundle 'ujihisa/unite-locate'
"NeoBundle 'violetyk/cake.vim'
"NeoBundle 'tpope/vim-surround'
"NeoBundle 'taglist.vim'
"NeoBundle 'ZenCoding.vim'


" 4.
NeoBundle 'TwitVim'

" 5. git
"NeoBundle 'fugitive.vim'

" 6.
"NeoBundle 'The-NERD-tree'
"NeoBundle 'The-NERD-Commenter'
"NeoBundle 'thinca/vim-localrc'
"NeoBundle 'motemen/hatena-vim'
"NeoBundle 'mattn/unite-advent_calendar'



filetype plugin indent on



