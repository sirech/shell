# -*- mode: Shell-script-*-
#
# Installation script for the irbrc configuration

echo "Installing gems"
gem install awesome_print -v0.2.1
gem install bond -v0.2.2
gem install hirb -v0.3.3
gem install looksee -v0.2.1
gem install map_by_method -v0.8.3
gem install net-http-spy -v0.2.1
gem install sketches -v0.1.1
gem install what_methods -v1.0.1
gem install wirble -v0.1.3

echo "Linking to .irbrc"
ln -s ${SHELL_DIR}/irbrc/irbrc ~/.irbrc
