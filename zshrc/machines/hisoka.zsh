# -*- mode: Shell-script-*-

#
# Settings for the machine 'hisoka'
#

## ENV

# Access JIRA from the console

## ALIASES
alias tf=terraform

## Setup
export N_PREFIX=$HOME/.n
[ -d $N_PREFIX ] && export PATH=$N_PREFIX/bin:$PATH

DAYTONA_INIT=~/work/dev-tools/etc/shell-init.sh
[ -f $DAYTONA_INIT ] && . $DAYTONA_INIT
