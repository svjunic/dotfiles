#####################################################################################################
# 共通設定
#####################################################################################################
# 色の変更
export LSCOLORS=gxfxcxdxbxegedabagacad


#####################################################################################################
# nvm
#####################################################################################################
# echo "add PATH for node.js"
# export PATH="/usr/local/bin:$PATH:/usr/local/sbin"
# 
# source ~/.nvm/nvm.sh
# nvm use v0.10.28
# npm_dir=${NVM_PATH}_modules
# 
# echo "set NODE_PATH for node.js"
# export NODE_PATH=$npm_dir


#####################################################################################################
# alias
#####################################################################################################
alias ls='ls -G'
alias cdc='cd `pwd -P`'
alias vi='Vim'
alias vim='Vim'

alias openf='sh ~/bin/openf'
alias gitlocal_refresh='sh ~/bin/gitlocal_refresh.sh'
alias adbDebug='sh ~/bin/androidDebug.sh'

alias tmux-session-clear='tmux kill-session -a'


#####################################################################################################
# function
#####################################################################################################
# 不要ファイルを一度に削除したかった。
function ccc () {
  rm `find ./* -name .DS*`
  rm `find ./* -name *.swp`
  rm `find ./* -name Thumbs.db`
  return
}

# scss 単体コンパイル
function scss_compile () {
  filename=$(echo $1 | sed 's/.scss$//g')
  scss --compass ${filename}.scss ${filename}.css -C --sourcemap=none --style compressed
  return
}


#####################################################################################################
# MacVim
#####################################################################################################
export PATH="/Applications/MacVim.app/Contents/MacOS:$PATH"


#####################################################################################################
# cordova
#####################################################################################################
# export PATH="$PATH:/Applications/AndroidSDK/adt-bundle-mac-x86_64-20140321/sdk/tools/"
# export PATH="$PATH:/Applications/AndroidSDK/adt-bundle-mac-x86_64-20140321/sdk/platform-tools/"


#####################################################################################################
# nginx
#####################################################################################################
# export PATH="/usr/local/nginx/sbin:$PATH"


#####################################################################################################
# git
#####################################################################################################
# git config --global credential.helper cache --timeout=86400
# git config --global core.editor /Applications/MacVim.app/Contents/MacOS/Vim
# 空コミット
# git commit --allow-empty -m "make pull request"

#差分ファイル出すとき用
# git_diff_archive 識別子1 識別子2
. ~/bin/git_diff_archive.sh

# peco,vim,pt
. ~/bin/ptvim.sh
git config --global color.ui auto
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global alias.hist 'log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short'


#####################################################################################################
# zsh
#####################################################################################################
# zsh


#####################################################################################################
# tmux
#####################################################################################################

if [ `which tmux` ]; then
  # いつもつかってるalias追加
  . ~/bin/tmux/alias.sh
  # セッションがあればアタッチ、なければ起動
  # -dをつけると他の接続が全てデタッチされ、今回アタッチする画面サイズに調整してくれる。
  tmux a -d || tmux
fi

