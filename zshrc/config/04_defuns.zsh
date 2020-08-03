# -*- mode: Shell-script-*-
#
# General functions
#

rg() {
  if [ -t 1 ]; then
    command rg -C 1 -p "$@" | less -RFX
  else
    command rg "$@"
  fi
}
