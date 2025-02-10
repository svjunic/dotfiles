source ~/.profile
echo 'include .bash_profile'

test -r ~/.bashrc && . ~/.bashrc

if [ -f ~/.bashrc_local ]; then
  test -r ~/.bashrc_local && . ~/.bashrc_local
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
. "/Users/sv.junic/.deno/env"
source /usr/local/etc/bash_completion.d/deno.bash