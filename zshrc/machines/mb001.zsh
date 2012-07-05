# -*- mode: Shell-script-*-

#
# Settings for the machine 'mb001'
#

## LOADING STUFF

#. ~/.rvm/scripts/rvm

## ENV

activate-proxy 10.0.175.40 3128

## DEFUNS

function smart_ssh() {
    if [[ "$@" =~ intqm ]] && [[ ! "$@" =~ intqmbuild01 ]] ; then
        command ssh -t intqmbuild01 command ssh -t $@
    else
        command ssh $@
    fi
}

## ALIASES

# Remap ssh
alias ssh='smart_ssh'
compdef _ssh smart_ssh=ssh
