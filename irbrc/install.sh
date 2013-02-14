# -*- mode: Shell-script-*-
#
# Installation script for the irbrc configuration

echo "Installing gems"
gem install awesome_print
gem install bond
gem install hirb
gem install looksee
gem install map_by_method
gem install net-http-spy
gem install sketches
gem install what_methods
gem install wirble

echo "Linking to .irbrc"
ln -s ${SHELL_DIR}/irbrc/irbrc ~/.irbrc
