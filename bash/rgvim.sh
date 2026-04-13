_rgvim_open_selected() {
  local sel file line col
  sel=$1
  [[ -z $sel ]] && return

  if [[ $sel =~ ^(.*):([0-9]+):([0-9]+): ]]; then
    file=${BASH_REMATCH[1]}
    line=${BASH_REMATCH[2]}
    col=${BASH_REMATCH[3]}
  else
    IFS=: read -r file line col _ <<< "$sel"
  fi

  vim +"call cursor(${line:-1},${col:-1})" -- "$file"
}

rgvim() {
  local sel
  sel=$(rg --no-heading --line-number --column "$@" | fzf --layout=reverse --tmux center,80%,80% --query "${LBUFFER-}") || return
  _rgvim_open_selected "$sel"
}
