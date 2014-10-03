# -*- mode: Shell-script-*-

#
# Mac OS X specific settings
#

## DEFUNS

# Changes the profile of the current Terminal window to the given one.
function change_profile() {
    /usr/bin/osascript <<EOF
    tell application "Terminal" to set current settings of first window to settings set named "${1:?No profile name provided}"
EOF
}

# Launch gitk with using native widgets
function nice_gitk() {
   if [ -f /usr/bin/gitk ] ; then
     /usr/bin/wish /usr/bin/gitk
   else
     /usr/bin/wish /usr/local/bin/gitk
   fi
}


## ENV

export JAVA_HOME="/Library/Java/Home"
export ANT_HOME="/usr/share/ant"

# Use colors than can actually be seen
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

if test $(which brew); then
  export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi

## ALIASES

# cleanup DS_Store files in the current directory
alias dsclean='find . -name ".DS_Store" | xargs rm'

# Use native Tk to launch gitk
alias gitk="nice_gitk"
compdef _git nice_gitk=git-log
