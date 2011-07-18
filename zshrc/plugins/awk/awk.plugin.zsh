## EXTENDED AWK

# Allows to call awk with an inline expression and use the available
# libraries. To do this, the expression is converted into a temporary
# awk script, which is passed to the awk command as well as every
# available library
function eawk () {

    if [ -z "$1" ]; then
        echo 'no script provided'
        exit 1
    fi

    local script
    local CMD
    local LIBS

    # Convert input to a temporary script
    script=/tmp/eawkscript${RANDOM}.awk
    echo $1 > $script

    # Thanks to http://www.linuxforums.org/forum/programming-scripting/62564-bash-script-problem-preserving-quotes-arguments.html
    CMD="$2"
    for (( i = 3; i <= $# ; i++ )); do
        eval ARG=\$$i
        CMD="$CMD $ARG"
        # CMD="$CMD $(echo "$ARG" | awk '{gsub(".", "\\\\&");print}')"
    done

    # Get all the available libraries
    LIBS=""
    for lib in ${AWK_FUNCS}/* ; do
        if [ -f $lib ] ;
        then
            LIBS="$LIBS -f $lib"
        fi
    done

    # Call awk
    if [ -z "$CMD" ]; then
        awk $LIBS -f $script # Avoid call with trailing whitespace
    else
        awk $LIBS -f $script "$CMD"
    fi

    rm $script
}

# Surrounds every line in the input stream with the given delimiter,
# ignoring empty lines
function surround() {
    eawk '$0!~/^$/ { print delimiter$0delimiter; }' delimiter="${1:?No delimiter provided}"
}

# Joins all the lines from the input stream into one single line,
# putting the given delimiter in between them
function oneline() {
    eawk 'BEGIN { line=""; } $0!~/^$/ { line=line$0delimiter; } END { print take(line, length(line) - length(delimiter)); }' delimiter="${1:?No delimiter provided}"
}

# Separates a single line in multiple lines, using a delimiter to
# separate the lines
function separate() {
    eawk 'END { n = split($0, a, delimiter); for(i=1; i <= n; i++) { print a[i] } }' delimiter="${1:?No delimiter provided}"
}
