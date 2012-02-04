# -*- mode: Shell-script-*-
#
# Backup stuff
#

function backup_wiki() {

    local dropbox
    dropbox=`find ~/. -name Dropbox`

    local remote
    remote=/srv/www/moin/wiki
    ssh erza remote_backup_wiki
    scp erza:${remote}/*bckp*.zip ${dropbox}/backups
    ssh erza rm ${remote}/*bckp*.zip
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
