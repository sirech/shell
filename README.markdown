# Shell config

This project provides a set of defaults, configuration files and
extensions for shell work.

## BASH

See `bashrc/README.markdown`.

## ZSH

See `zshrc/README.markdown`.

## Dot files

There are configuration files for some common programs. To use them,
link them with something like:

`ln -s ~/shell/progrc ~/.progrc`

where _progrc_ is one of:

 * inputrc
 * ackrc
 * screenrc
 * tmux.conf (link to `.tmux.conf` instead)
 * vimrc
 * wgetrc
 * ctags (link to `.ctags`)

## Extra scripts

There are some executables in the scripts folder. The easiest way to
make them available is to link this folder to `~/bin`, with something
like:

`ln -s ~/shell/scripts ~/bin`

## SSH

See `ssh/README.markdown`.

## GIT

See `git/README.markdown`.

## Utilities

### ACK

_Very_ useful.

* Mac OS X: `sudo port install p5-app-ack`

* Linux: `apt-get install ack-grep`

The configuration file is automatically loaded.

### Ruby

#### RVM

Best option for _ruby_ hacking. To install it, follow these steps
_exactly_.

1. Download _rvm_ by typing `bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)`

2. Load it with `. ~/.rvm/scripts/rvm` (best put in the user
configuration).

3. Add completion with `ln -s ~/.rvm/scripts/completion ~/shell/bash/completion/rvm`

4. Reload config

To install _ruby_ itself, follow this _exactly_. This applies for
version 1.9.2:

1. Install _zlib_, _openssl_, and _readline_ with `rvm package install
lib`, where lib is each of these libraries. Mac OS X might give some
compilation error, but it doesn't seem to matter.

2. Install _ruby_ with `rvm install 1.9.2 --with-openssl-dir=$rvm_path/usr --with-zlib-dir=$rvm_path/usr --with-readline-dir=$rvm_path/usr`.

3. Mark the version with `rvm --default use 1.9.2`.

(To test if this worked, `gem install bundler`. More info
[](https://rvm.beginrescueend.com/packages/zlib/)).

It might happen that _readline_ does not work. If _irb_ gives a weird
error, follow the instructions in this
[Stack Overflow post](http://stackoverflow.com/questions/4498919/problems-with-the-rails-console-rvm-and-readline).)

#### rbenv & ruby-build

An alternative to _rvm_, follow these steps:

1. Install _readline_:

    * Linux: sudo apt-get install libreadline-dev

    * Mac OS X: brew install readline && brew link readline

2. Install _zlib_:

    * Linux: sudo apt-get install libssl-dev zlib1g-dev

3. _rbenv_: Go to https://github.com/sstephenson/rbenv , follow the
installation steps. Keep in mind that most of the path setting is
already taken care of by the _zsh_ configuration.

4. _ruby-build_: Go to https://github.com/sstephenson/ruby-build ,
follow the instructions to install it as a _rbenv_ plugin.

5. _rbenv-update_: Useful plugin. Clone the repo
_git://github.com/rkh/rbenv-update.git_ in `~/.rbenv/plugins`.

Note that if you want to use _irb_, you have to install a ruby version
with _readline_ support. Do it like this:

`CONFIGURE_OPTS="--with-readline-dir=/usr/include/readline" rbenv install 1.9.3-p194`

For Mac OS X:

`CONFIGURE_OPTS="--with-readline-dir=/usr/local" rbenv install 1.9.3-p194`

#### irb

Follow the instructions in `irbrc/README.textile`.

### MongoDB Shell

Follow the instructions in `mongorc/README.md`.

### emacsclient

To use _emacsclient_ properly, don't use the version that ships with
the OS. Link the good one with `sudo ln -s
/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
/usr/local/bin/emacsclient`.

### Standard error in red

Clone the repository with `git clone
git://github.com/sickill/stderred.git` and follow the instructions in
https://github.com/sickill/stderred
