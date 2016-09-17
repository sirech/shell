# -*- mode: Shell-script-*-

#
# Mac OS X specific settings
#

## ENV

# Use colors than can actually be seen
export CLICOLOR=1

if test $(which brew); then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

## ALIASES

# htop needs to run with sudo to work properly
alias htop='sudo htop'

alias godocs='cd ~/Documents'
