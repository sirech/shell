# -*- mode: Shell-script-*-
#
# Installation script for the irbrc configuration

echo "Installing gems in irbrc.gems"
rvm gemset import irbrc.gems
echo "Linking to .irbrc"
ln -s ~/irbrc/irbrc ~/.irbrc
