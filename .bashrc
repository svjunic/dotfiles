#####################################################################################################
# 共通設定
#####################################################################################################
# 色の変更
export LSCOLORS=gxfxcxdxbxegedabagacad

# ターミナルのカスタマイズ
# \h  ホスト名（最初の.まで）
# \H  ホスト名
# \t  時間（24時間形式）
# \u  ユーザー名
# \w  現在のディレクトリ(フルパス)
# \W  現在のディレクトリ名
#PS1="\u: \W $"
PS1="\u \t[\w] $ "

#####################################################################################################
# nvm
#####################################################################################################
echo "add PATH for node.js"
export PATH="/usr/local/bin:$PATH:/usr/local/sbin"

source ~/.nvm/nvm.sh
nvm use v7.10.0
npm_dir=${NVM_PATH}_modules

echo "set NODE_PATH for node.js"
export NODE_PATH=$npm_dir


#####################################################################################################
# alias
#####################################################################################################
case "${OSTYPE}" in
darwin*)
  alias ls="ls -G"
  alias ll="ls -lG"
  alias la="ls -laG"
  alias openf='sh ~/bin/openf'
  ;;
linux*)
  alias ls='ls --color'
  alias ll='ls -l --color'
  alias la='ls -la --color'
  ;;
esac
alias cdc='cd `pwd -P`'
alias vi='Vim'
alias vim='Vim'

alias gitdiff='git difftool --tool=vimdiff --no-prompt'
alias gitlmm='git log origin/master..master'
#alias adbDebug='sh ~/bin/androidDebug.sh'

alias tmux-session-clear='tmux kill-session -a'

# ディレクトリの容量表示
alias dud='du -d 1 -h '


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
function scss1compile () {
  filename=$(echo $1 | sed 's/.scss$//g')
  scss --compass ${filename}.scss ${filename}.css -C --sourcemap=none --style compressed
  return
}
function scss1watch () {
  filename=$(echo $1 | sed 's/.scss$//g')
  scss --watch${filename}.scss:${filename}.css -C --sourcemap=none --style compressed
  return
}
function scsswwatch () {
  input=$1
  output=$2
  scss --watch ${input}:${output} -C --sourcemap=none --style compressed
  return
}


#####################################################################################################
# MacVim
#####################################################################################################
if [ "$(uname)" == 'Darwin' ]; then
  export PATH="/Applications/MacVim.app/Contents/MacOS:$PATH"
fi

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
#git config --global alias.st status
git config --global alias.br branch
git config --global alias.hist 'log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short'

git config --global alias.st  'status --branch --short'
git config --global alias.sl  'log --all --branches --decorate --graph --oneline'
git config --global alias.log 'log --all --branches --graph'

#git config --global alias.log 'log --all --branches --graph'
#git show-branch --merge-base master HEAD
#git diff `git show-branch --merge-base master HEAD` HEAD


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


#####################################################################################################
# peco
#####################################################################################################
function cdd {
  local dir=$(find ./* -type d | peco)
  if [ ! -z "$dir" ] ; then
      cd "$dir"
  fi
}

function cdf () {
  local dir=$(find ./* -type f | peco)
  if [ ! -z "$dir" ] ; then
    vi "$dir"
  fi
}


#####################################################################################################
# github
#####################################################################################################
source ~/bin/git-completion.bash
source ~/bin/git-prompt.sh
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWSTASHSTATE=1
export PS1='\[\e[0;37m\e[40m\]\u\[\e[0m\]:\[\e[0;96m\e[40m\]\w\[\e[1;92m\e[40m\]$(__git_ps1)\[\e[0m\] $ '


#####################################################################################################
# function
#####################################################################################################
# ctrl+fで次の単語に移動
bind '"\C-f": forward-word'
# ctrl+bで前の単語に移動
bind '"\C-b": backward-word'


#####################################################################################################
# fake-dev
#####################################################################################################
alias fake-dev="nginx -p . -c ~/.fake-dev.conf"
