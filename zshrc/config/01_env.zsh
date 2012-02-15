# -*- mode: Shell-script-*-
#
# File with environment variables
#

# Common path
path=(/usr/local/bin /opt/local/bin $path ~/bin)
manpath=($manpath /opt/local/share/man)
infopath=($infopath /opt/local/share/info)

# Edit with emacs
export EDITOR="emacsclient"
export ALTERNATE_EDITOR="emacs"
export EMACS_DIR="${HOME}/.emacs.d"

# Folders with libraries for some languages
export AWK_FUNCS=${SHELL_DIR}/awk/lib
export PYTHON_FUNCS=${SHELL_DIR}/python

# Folder with hooks for git
export GIT_HOOKS=${SHELL_DIR}/git/hooks

# Log directory access variables
export DIRLOGSDB=~/.dirlogsdb
export LASTDIR=/

# Avoid annoying completion problems when ssh'ing to a machine with a
# different locale
unset LC_CTYPE
