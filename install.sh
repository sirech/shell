# -*- mode: Shell-script-*-
#!/usr/bin/bash
#
# Installation script for remote machines
if [ ! -d "~/shell" ] ; then
    rm ~/shell
    ln -s "$(dirname $0)" ~/shell
fi

sh $(dirname $0)/scripts/prepare-remote-machine
