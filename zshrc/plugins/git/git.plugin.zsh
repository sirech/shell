load_old_plugin $0

# Aliases

alias gs='git status'
compdef _git gs=git-status
alias gpa='git push -v && git push -v public master'
compdef _git gpa=git-push
alias gu='git pull -v'
compdef _git gu=git-pull
alias gup='git pull -v && git push -v'
alias ga='git add -v'
compdef _git ga=git-add
alias gd='git diff'
compdef _git gd=git-diff
alias gl='git log'
compdef _git gl=git-log
