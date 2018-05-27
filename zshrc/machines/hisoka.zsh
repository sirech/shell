# -*- mode: Shell-script-*-

#
# Settings for the machine 'hisoka'
#

## ENV
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# Access JIRA from the console

## ALIASES
alias tf=terraform

## Setup
script_dir=~/workspace/cloud-helpers
source ${script_dir}/cloud-helpers.sh
# source ${script_dir}/cloud-helpers-completion.sh
