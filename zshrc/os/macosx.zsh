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
  [ -d /usr/local/opt/coreutils ] && export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
  [ -d /usr/local/opt/findutils ] && export PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH
  [ -d /usr/local/opt/grep ] && export PATH=/usr/local/opt/grep/libexec/gnubin:$PATH
  [ -d /usr/local/opt/gnu-sed ] && export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$PATH

  [ -d /usr/local/opt/openssl/lib ] && export LIBRARY_PATH=/usr/local/opt/openssl/lib:$LIBRARY_PATH
fi

## ALIASES

# htop needs to run with sudo to work properly
alias htop='sudo htop'

alias godocs='cd ~/Documents'

alias l='ls -lah --color=auto'
