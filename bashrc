# -*- mode: Shell-script-*-
#
# Base file, that loads all the other settings.
# This file can be loaded from the .bashrc file with something like this:
#      . (PATH_TO_FOLDER_OF_THIS_FILE)/bashrc
#
# To add OS-specific settings, create a file with the settings and add
# a clause to the case. An OS is identified by the result of the uname function.
#
# To add machine-specific settings, create a file, using the result of
# the ehostname function as the name. The file will be loaded
# automatically.
#
# To add completion files, put them in the completion folder. Bash
# completion depends on an environment variable, defined in the
# OS-specific settings file.
#
# Author: Mario Fernandez

# Don't allow echo in non-interactive terminals
PS1_COPY=${PS1}
function cfg_echo () {
    if [ -n "${PS1_COPY}" ]; then
        echo $@
    fi
}

# Change this variable to the path of the folder that contains the bashrc file.
SHELL_DIR="${HOME}/shell"

if [ ! -d ${SHELL_DIR} ] ; then
    cfg_echo "Directory ${SHELL_DIR} does not exist"
    exit 1
fi

. ${SHELL_DIR}/bash/env
. ${SHELL_DIR}/bash/config
. ${SHELL_DIR}/bash/defuns
. ${SHELL_DIR}/bash/aliases

# OS-specific settings
cfg_echo "Loading settings for OS: $(uname -s)"
case $(uname -s) in
    Darwin ) . ${SHELL_DIR}/bash/macosx ;;
    CYGWIN_NT* ) . ${SHELL_DIR}/bash/cygwin ;;
    Linux ) . ${SHELL_DIR}/bash/linux ;;
esac

# Machine-specific settings
if [ -f ${SHELL_DIR}/bash/users/$(ehostname) ];
then
    cfg_echo "Loading settings for user: $(ehostname)"
    . ${SHELL_DIR}/bash/users/$(ehostname)
fi

# Load bash-completion
if [ -n ${BASH_COMPLETION:+1} ] && [ -f $BASH_COMPLETION ] ;
then
    cfg_echo "Loading bash completion file"
    . $BASH_COMPLETION
    for file in ${SHELL_DIR}/bash/completion/*
    do
        cfg_echo "Loading completion file: $file"
        . $file
    done
fi

# Make sure scripts are executable
for f in ${SHELL_DIR}/scripts/* ; do
    if [ -f $f ] ;
    then
        chmod +x $f
    fi
done

# Activate directory logging
if [ -n "${PS1_COPY}" ] && [ -f ${DIRLOGSDB} ] ; then
    export PROMPT_COMMAND="prompt_command"
else
    export PROMPT_COMMAND=""
fi

# Go to the last directory
if [ -d ${STORED_LASTDIR} ]; then
    cd $(cat ${STORED_LASTDIR})
fi

