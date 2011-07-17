# -*- mode: Shell-script-*-
#
# Backup stuff
#

function backup_wiki() {

    local dropbox
    dropbox=`find ~/. -name Dropbox`

    ssh hceris remote_backup_wiki
    scp hceris:~/wiki/*bckp*.zip ${dropbox}/backups
    ssh hceris rm wiki/*bckp*.zip
}

# Backups both the emacs and shell configurations to dropbox
function backup_config() {

    local dropbox
    dropbox=`find ~/. -name Dropbox`

    goemacs
    git-export-zip
    mv *bckp*.zip ${dropbox}/backups

    goshell
    git-export-zip
    mv *bckp*.zip ${dropbox}/backups
}
