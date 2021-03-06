#!/bin/bash

pwd=`pwd -P`

if [ `uname` = "Darwin" ]; then
  #mac用のコード
  ln -s ${pwd}/.bash_profile ~/.bash_profile
  ln -s ${pwd}/.bashrc ~/.bashrc
  #ln -s ${pwd}/.eslintrc ~/.eslintrc
  ln -s ${pwd}/.eslintrc.js ~/.eslintrc.js
  ln -s ${pwd}/.prettierrc.yaml ~/
  ln -s ${pwd}/.tmux ~/.tmux
  ln -s ${pwd}/.tmux.conf ~/.tmux.conf
  #bash ${pwd}/vim_mac.sh
elif [ `uname` = "Linux" ]; then
  #Linux用のコード
  ln -s ${pwd}/.bashrc ~/.bashrc
  ln -s ${pwd}/.eslintrc.js ~/.eslintrc.js
  ln -s ${pwd}/.prettierrc.yaml ~/
  ln -s ${pwd}/.tmux ~/.tmux
  ln -s ${pwd}/.tmux.conf ~/.tmux.conf
  #bash ${pwd}/vim_linux.sh
fi
