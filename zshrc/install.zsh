# -*- mode: Shell-script-*-

#
# Sets up the configuration for zsh
#
# NOTE: the directory where the configuration is installed is in the
# variable ZSH, which you should modify accordingly

ZSH=~/shell/zshrc

# Link zshrc
ln -s ${ZSH}/zsh ~/.zshrc

# Clone oh-my-zsh, change it to devel branch
git clone git@github.com:sirech/oh-my-zsh.git ~/.oh-my-zsh
pushd
cd ~/.oh-my-zsh
git checkout devel
popd

# Clone zsh-completions
git clone git@github.com:zsh-users/zsh-completions.git ${ZSH}/completions
