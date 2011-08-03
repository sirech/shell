load_old_plugin $0

# Defuns

# Calls svn, running the output through a colorizer script
function svn_color() {
    python ${PYTHON_FUNCS}/svn_color.py "$@"
}

# Shows the diff command, paging the output
function svn_diff_tabbed() {
    svn_color diff -x -b "$@" | less -rXF
}

# Aliases

alias svnr='svn-revert-all'
alias svna='svn_color add'
alias svns='svn_color status'
alias svnu='svn_color update'
alias svnc='svn_color commit'
alias svnd='svn_diff_tabbed'
alias svnl='svn_color log -l 25 | less -rF'
