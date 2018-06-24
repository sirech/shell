# -*- mode: Shell-script-*-
#
# File functions to navigate to directories
#

## FUNCTIONS

# Goes to the directory that contains the emacs config
function goemacs() {
    cd -P ${EMACS_DIR}
}

# Goes to the directory that contains the shell config
function goshell() {
    cd -P ${SHELL_DIR}
}

# Goes to the directory where the workspace is located
function gospace() {
    cd -P ${WORKSPACE}
}
