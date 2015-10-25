# -*- mode: Shell-script-*-
#!/usr/bin/bash
#
# Installation script for the rc files

echo "Installing rc files"

exclude="install.sh README.markdown"

# Using the env var is causing problems for remote machines
DIR="$( cd "$( dirname "$0" )" && pwd )"

for f in ${DIR}/* ; do
    rc=$(basename "$f")

    if [ ! "${exclude#*$rc}" != "$exclude" ] ; then
        echo "Linking $rc"
        link=~/.${rc}

        if [ -h "${link}" ] ; then
           rm ${link}
        fi

        ln -s ${SHELL_DIR}/rc/${rc} ${link}
    fi
done
