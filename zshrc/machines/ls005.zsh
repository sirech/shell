# -*- mode: Shell-script-*-

#
# Settings for the machine 'ls004'
#

## ENV

export CUCUMBER_HOST=stable-mario-fernandez.env.xing.com
export JRE_HOME=/opt/jre

path=($JRE_HOME/bin $path)

function app_servers_old {
    echo events-1.app.fra{1,2}.xing.com
}

function api_servers_old {
    echo events-{1,2}.api.fra{1,2}.xing.com
}

function worker_servers_old {
    echo events-1.worker.fra{1,2}.xing.com
}

function app_servers {
    echo events-{2,3}.app.fra{1,2}.xing.com
}

function api_servers {
    echo events-{3,4}.api.fra{1,2}.xing.com
}

function worker_servers {
    echo events-{2,3}.worker.fra{1,2}.xing.com
}

function multirun {
    host=${1:?No hosts given}
    cmd=${2:?No cmd given}

    case $host in
        app )
            boxes=$(app_servers) ;;
        api )
            boxes=$(api_servers) ;;
        worker )
            boxes=$(worker_servers) ;;
    esac

    mussh -h $boxes -c $cmd
}

