load_old_plugin $0

## ENVIRONMENT

# Git completion is very slow for big repositories
__git_files () {
    _wanted files expl 'local files' _files
}

## FUNCTIONS

## ALIASES

alias gs='git status'
alias gu='git pull -v'
alias gup='git pull -v && git push -v'
alias ga='git add -v'
alias gd='git diff'
alias gl='git lg'
alias gw='git-wtf'
alias gf='git fetch'
alias gr='git rebase'
