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

# Goes to the directory where work stuff is located
function gowork() {
    cd -P ${WORKSPACE}
}

# Goes to the directory where personal stuff is located
function gomine() {
    cd -P ${MINE}
}
