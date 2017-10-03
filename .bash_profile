test -r ~/.bashrc && . ~/.bashrc

if [ -f ~/.bashrc_local ]; then
  test -r ~/.bashrc_local && . ~/.bashrc_local
fi
