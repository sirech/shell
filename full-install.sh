# -*- mode: Shell-script-*-
#!/usr/bin/bash
#
export SHELL_DIR=${HOME}/shell

sh $(dirname $0)/scripts/prepare-remote-machine

# ZSH
if [ ! -h "${HOME}/.zshrc" ] ; then
    ln -s ${SHELL_DIR}/zshrc/zsh ~/.zshrc
fi

chsh -s /bin/zsh

# SSH
if [ ! -h "${HOME}/.ssh/config" ] ; then
    ln -s ${SHELL_DIR}/ssh/config ${HOME}/.ssh/config
fi

# GPG
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
if [ ! -h "${HOME}/.gnupg/gpg-agent.conf" ] ; then
    ln -s ${SHELL_DIR}/gpg/gpg-agent.conf ${HOME}/.gnupg
fi

# GIT
if [ ! -h "${HOME}/.gitignore" ] ; then
    ln -s ${SHELL_DIR}/git/gitignore ~/.gitignore
fi

sudo update-alternatives --config wish
