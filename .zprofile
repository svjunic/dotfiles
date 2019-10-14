echo 'include .zbash_profile'
test -r ~/.zbashrc && . ~/.zbashrc

if [ -f ~/.bashrc_local ]; then
  test -r ~/.zbashrc_local && . ~/.zbashrc_local
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

