# -*- mode: Shell-script-*-

#
# Mac OS X specific settings
#

## ENV

# Use colors than can actually be seen
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

if test $(which brew); then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

if [[ -d "${HOME}/Library/Android/sdk/platform-tools" ]]; then
  echo "Android Studio is present, adding to path"
  export PATH=$PATH:~/Library/Android/sdk/platform-tools
fi

## ALIASES

# htop needs to run with sudo to work properly
alias htop='sudo htop'

alias godocs='cd ~/Documents'

alias l='ls -lah --color=auto'
