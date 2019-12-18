# -*- mode: Shell-script-*-

#
# Mac OS X specific settings
#

## DEFUNS

function restart_sound() {
  sudo kill -9 `ps ax| grep 'coreaudio[a-z]' | awk '{print $1}'`
}

## ENV

# Use colors than can actually be seen
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

if test $(which brew); then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

## ALIASES

# htop needs to run with sudo to work properly
alias htop='sudo htop'

alias godocs='cd ~/Documents'

alias l='ls -lah --color=auto'

## NVM

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
