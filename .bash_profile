echo 'include .bash_profile'
test -r ~/.bashrc && . ~/.bashrc

if [ -f ~/.bashrc_local ]; then
  test -r ~/.bashrc_local && . ~/.bashrc_local
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

