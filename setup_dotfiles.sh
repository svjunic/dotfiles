#!/bin/bash

if [ `uname` = "Darwin" ]; then
  #mac用のコード
  cp .bash_profile ~/.bash_profile
  cp .tmux.conf ~/.tmux.conf
  bash ./vim_mac.sh
elif [ `uname` = "Linux" ]; then
  #Linux用のコード
  cp .profile ~/.profile
  cp .tmux.conf ~/.tmux.conf
  bash ./vim_linux.sh
fi