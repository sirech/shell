# -*- mode: Shell-script-*-
#
# General functions
#

rg() {
  if [ -t 1 ]; then
    command rg --hidden -C 1 -p "$@" | less -RFX
  else
    command rg --hidden "$@"
  fi
}
