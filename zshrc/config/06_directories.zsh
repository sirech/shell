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

# This function is executed each time that the current directory is
# changed
function chpwd () {
    # Log directory access
    if [ -f ${DIRLOGSDB} ]; then
        local newdir

        newdir=`pwd`
        if [ ! "$LASTDIR" = "x$newdir" ]; then
            python ${PYTHON_FUNCS}/directory_log.py
        fi

        LASTDIR=x$newdir
    fi
}

# Builds the directory database
function build_logging_db () {
    python ${PYTHON_FUNCS}/directory_build.py
}

# Counts the sum of the lines for the files with the given extension
function count_lines_in_files() {
    find . -name "*.${1:?No extension provided}" -exec wc -l '{}' \; | awk '{ sum += $1 } END { print sum }'
}

# Looks for the given class inside the jar files in the given
# directory. Subdirs are also considered in the search for jar files.
function find_class_in_jars() {

    for i in `find . -name *.jar`; do
        echo $i
        jar -tvf $i | grep "${1:?No class name provided}"
    done
}


## ALIASES

alias go='go_frequency'
alias gor='go_recent'
