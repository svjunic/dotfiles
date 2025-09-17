#####################################################################################################
# function
#####################################################################################################
# load nvm

function load_npm () {
  echo "add PATH for node.js"
  export PATH="/usr/local/bin:$PATH:/usr/local/sbin"

  source ~/.nvm/nvm.sh
  #nvm use v20.18.0
  nvm use --lts

  alias node="node --experimental-modules"
  echo "set NODE_PATH for node.js"
  export NODE_PATH=$npm_dir
}

#####################################################################################################
# nvm
#####################################################################################################

function npm () {
  echo 'npm function'
  unset -f npx
  unset -f npm
  load_npm

  if [ ! -z $1 ]; then
    npm $@
  fi
}

function npx () {
  echo 'npm function'
  unset -f npx
  unset -f npm
  load_npm

  if [ ! -z $1 ]; then
    npx $@
  fi
}

function node_vi () {
  unalias vi
  alias vi='nvim'

  if ! (type "node" > /dev/null 2>&1) ; then
    load_npm
  fi

  if [ ! -z $1 ]; then
    nvim $@
  else
    nvim
  fi
}
