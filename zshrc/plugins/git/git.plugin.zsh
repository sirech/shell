load_old_plugin $0

## FUNCTIONS

# Create local repo, synchronize with remote one
function newgit() {

    local repo

    if [ -z "$1" ]; then
        echo 'usage: repo_name'
        exit 1
    fi

    repo=$1.git

    create_git_local $repo
    sync_remote_git $repo
}

# Create a new local repository
function create_git_local() {

    if [ -z "$1" ]; then
        echo 'usage: repo_name'
        exit 1
    fi

    if [ -z ${WORKSPACE:+1} ]; then
        echo 'env variable WORKSPACE is not set'
        exit 1
    fi

    echo "Creating repository named $1"

    cd $WORKSPACE
    mkdir $1
    cd $1
    git init
    touch .gitignore
    echo '.DS_Store' >> .gitignore
    echo '*~' >> .gitignore
    echo '#*#' >> .gitignore
    git add .gitignore
    git commit -m "setup"
}

# Synchronize the repository in the current directory with a remote one
function sync_remote_git () {

    if [ -z "$1" ]; then
        echo 'usage: repo_name'
        exit 1
    fi

    echo "Synchronizing repository $1 with the remote version"

    ssh hceris new_remote_git $1
    git remote add origin ssh://hceris/~/git.hceris.com/$1
    git config branch.master.remote origin
    git config branch.master.merge refs/heads/master
    git push --all
}

# Adds the git repository in the current directory to github
function add_to_github () {

    if [ ! -d .git ]; then
        echo 'the given directory is not a git repository'
        exit 1
    fi

    local dirname
    dirname=$(basename "$PWD")

    if [[ $dirname != *.git ]]; then
        echo 'the directory should end with .git'
        exit 1
    fi

    git remote add public git@github.com:sirech/${dirname}
    git push public master
}


## ALIASES

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
