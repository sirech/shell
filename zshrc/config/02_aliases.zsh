# -*- mode: Shell-script-*-
#
# General aliases
#

# most used commands
alias rank="history | awk '{a[\$2]++}END{for(i in a){print a[i] \" \" i}}' | sort -rn | head"

# less: allow color
alias less='less -r'

# edit file with set editor
alias edit="$EDITOR"

# find
alias f='find'

# ssh
alias s='ssh'

# unified diff
alias udiff='diff -u'

# current year
alias year='date +%Y'

# Show running processes, sorted
alias tu='top -o cpu' # cpu
alias tm='top -o vsize' # memory

# PS
alias psg="ps aux | grep "

# show me files matching "ls grep"
alias lsg='ll | grep'

# Global aliases
alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something

# Ag does not have a proper configuration file
alias ag='ag --pager "less -r" -C 1'
