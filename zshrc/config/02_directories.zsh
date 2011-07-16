# -*- mode: Shell-script-*-
#
# File functions to navigate to directories
#

# Goes to the directory that contains the emacs config
function goemacs() {
    cd -P ${EMACS_DIR}
}

# Goes to the directory that contains the shell config
function goshell() {
    cd -P ${SHELL_DIR}
}

# If called without arguments, presents a list of the most visited
# directories, as well as a number for each of them. If an argument is
# given, it changes to the directory identified by that number
function go_frequency () {
    go_to_directory directory_frequency.py $1
}

# Equivalent to go_frequency, but using a list of the most recently
# visited directories.
function go_recent () {
    go_to_directory directory_recent.py $1
}

# Implements the go_* functions
function go_to_directory () {
    local script
    local output

    script=${PYTHON_FUNCS}/$1
    if [ -z "$2" ]; then
        python ${script} | awk 'BEGIN { print "+ change to directory by selecting the number"; } { print NR": "$0; }'
    else
        cd "$(python ${script} | awk  -v line=$2 -v home=$HOME '{ if(NR == line) { sub(/~/, home); print $0; } }')"
    fi
}

# Builds the directory database
function build_logging_db () {
    python ${PYTHON_FUNCS}/directory_build.py
}


# Aliases
alias go='go_frequency'
alias gor='go_recent'
