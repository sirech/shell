# Sets up a proxy for the shell.
function activate-proxy () {
    export PROXY_HOST=${1:?No proxy host given}
    export PROXY_PORT=${2:?No proxy port given}

    for proxy in http_proxy HTTP_PROXY https_proxy HTTPS_PROXY ; do
        export $proxy=http://$PROXY_HOST:$PROXY_PORT/
    done
    export GIT_PROXY_COMMAND=git-proxy-cmd
}
