# -*- mode: Shell-script-*-
#
# Settings for auto completion
#

# Disable autocorrect
unsetopt correct_all
# Don't beep before showing matches
unsetopt list_beep
# Show list when some characters can be completed
unsetopt list_ambiguous

# Show a message when no matches are found
zstyle ':completion:*:warnings' format 'No matches: %d'
# Show the type of the completions offered
zstyle ':completion:*:descriptions' format %B%d%b
# Group matches by type
zstyle ':completion:*' group-name ''

# Deal with too many matches
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
bindkey -M listscroll q send-break

# Approximate matching
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) )'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# Don't complete the same subdirectory
zstyle ':completion:*' ignore-parents parent pwd
