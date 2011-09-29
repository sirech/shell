# Wirble is a set of enhancements for irb
# http://pablotron.org/software/wirble/README
# Implies require 'pp', 'irb/completion', and 'rubygems'
desire('wirble') do
  Wirble.init
  # Enable colored output
  Wirble.colorize
end
