# -*- mode: Shell-script-*-
#
# File with environment variables
#

# Common path
path=(/usr/local/bin /opt/local/bin $path ${SHELL_DIR}/scripts)
manpath=($manpath /opt/local/share/man)
infopath=($infopath /opt/local/share/info)

# Edit with emacs
export EDITOR="emacsclient"
export ALTERNATE_EDITOR="emacs"
export EMACS_DIR="${HOME}/.emacs.d"

# Folders with libraries for some languages
export AWK_FUNCS=${SHELL_DIR}/awk/lib
export PYTHON_FUNCS=${SHELL_DIR}/python

# Log directory access variables
export DIRLOGSDB=~/.dirlogsdb
export LASTDIR=/
