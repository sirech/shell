#
# String functions for awk
#
# Dependencies:
# - math.awk

# removes leading whitespace from a string
function ltrim(s) {
    sub(/^[ \t]+/, "", s);
    return s;
}

# removes trailing whitespace from a string
function rtrim(s) {
    sub(/[ \t]+$/, "", s);
    return s;
}

# removes leading and trailing whitespace from a string
function trim(s) {
    return rtrim(ltrim(s));
}

# returns the first n characters from a string
function take(s, n) {
    return substr(s, 1, min(n, length(s)));
}
