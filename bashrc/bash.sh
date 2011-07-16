# -*- mode: Shell-script-*-
#
# Base file, that loads all the other settings.
# This file can be loaded from the .bashrc file with something like this:
#      . (PATH_TO_FOLDER_OF_THIS_FILE)/bash.sh
#
# Author: Mario Fernandez

# Don't allow echo in non-interactive terminals
PS1_COPY=${PS1}
function cfg_echo () {
    if [ -n "${PS1_COPY}" ]; then
        echo $@
    fi
}

# Change this variable to the path of the folder that contains the
# bash directory.
SHELL_DIR="${HOME}/shell"

if [ ! -d ${SHELL_DIR} ] ; then
    cfg_echo "Directory ${SHELL_DIR} does not exist"
    exit 1
fi

. ${SHELL_DIR}/bashrc/env
. ${SHELL_DIR}/bashrc/config
. ${SHELL_DIR}/bashrc/defuns
. ${SHELL_DIR}/bashrc/aliases

# OS-specific settings
cfg_echo "Loading settings for OS: $(uname -s)"
case $(uname -s) in
    Darwin ) . ${SHELL_DIR}/bashrc/macosx ;;
    CYGWIN_NT* ) . ${SHELL_DIR}/bashrc/cygwin ;;
    Linux ) . ${SHELL_DIR}/bashrc/linux ;;
esac

# Terminal-Specific settings
cfg_echo "Loading settings for Terminal: $TERM"
case $TERM in
    screen|screen-w|xterm)
        export EXTRA_PROMPT_COMMAND=change_title
        ;;
esac

# Machine-specific settings
if [ -f ${SHELL_DIR}/bashrc/users/$(ehostname) ]; then
    cfg_echo "Loading settings for user: $(ehostname)"
    . ${SHELL_DIR}/bashrc/users/$(ehostname)
fi

# Load bash-completion
if [ -n ${BASH_COMPLETION:+1} ] && [ -f $BASH_COMPLETION ]; then
    cfg_echo "Loading bash completion file"
    . $BASH_COMPLETION
    for file in ${SHELL_DIR}/bashrc/completion/*
    do
        cfg_echo "Loading completion file: $file"
        . $file
    done
    # TODO: find out why this hangs with some commands
    cfg_echo "Generating completion for aliases"
    . ${SHELL_DIR}/bashrc/wrap_aliases
fi

# Make sure scripts are executable
for f in ${SHELL_DIR}/scripts/* ; do
    if [ -f $f ]; then
        chmod +x $f
    fi
done

# Activate directory logging
if [ -n "${PS1_COPY}" ]; then
    export PROMPT_COMMAND="prompt_command"
else
    export PROMPT_COMMAND=""
fi

# Go to the last directory
if [ -d ${STORED_LASTDIR} ]; then
    cd $(cat ${STORED_LASTDIR})
fi

