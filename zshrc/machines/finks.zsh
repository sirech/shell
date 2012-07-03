# -*- mode: Shell-script-*-

#
# Settings for the machine 'finks'
#

## LOADING STUFF

. ~/.rvm/scripts/rvm

## ENV

export _DOCS=${HOME}/Documents

# Closure compiler (for JavaScript)
export CLOSURE_COMPILER=${WORKSPACE}/closure-compiler/compiler.jar

export RSENSE_HOME=/opt/rsense

## DEFUNS

## ALIASES

# common dirs
alias gostuff="cd ${WORKSPACE}/stuff"
alias goalgs="cd ${WORKSPACE}/algorithms"
alias gores="cd ${_DOCS}/resume"
alias gocovers="cd ${_DOCS}/resume/covers-$(year)"
