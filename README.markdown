# Shell config

This project provides a set of defaults, configuration files and
extensions for shell work.

## BASH

See `bashrc/README.markdown`.

## Dot files

There are configuration files for some common programs. To use them,
link them with something like:

`ln -s ~/shell/progrc ~/.progrc`

where _progrc_ is one of:

 * inputrc
 * ackrc
 * screenrc
 * tmux.conf (link to .tmux.conf instead)
 * vimrc

## SSH

You can add ssh profiles in the ssh/config file. You'll need to link
it to your ssh config with something like `ln -s ~/shell/ssh/config
~/.ssh/config` .

To log without a key follow this advice: [RSA without
pass](http://linuxproblem.org/art_9.html)

### SSH through proxy

SSH might not work if there is a proxy in the middle. To fix this, a
proxy command has to be used. It's best to edit the
`/etc/ssh/ssh_config` file, with something along these lines:

    Host *
        ProxyCommand connect -S ${proxy.url}:${proxy.port} %h %p

    Host *.${internal.net}
        ProxyCommand connect %h %p

The proxy url and port are needed (the port is usually 1080) to access
external hosts. Internal hosts don't need to use the proxy.

Additionally, *connect* must be installed. It is a C program that can
be compiled and installed in the PATH. Instructions and download can
be found
[here](http://bent.latency.net/bent/git/goto-san-connect-1.85/src/connect.html#sec5).
    
## GIT

There are some functions to create new git repositories, synchronized
with a remote server. The prompt is modified to show the state of a
git repository, if we are in a folder that contains one.

### Git configuration

With git you can set a global configuration file, which contains
aliases, color settings and other useful things. Such a file is
included here, named _gitconfig_. The problem is, that as of Jan 2011,
there is no way to include other files in this config. Therefore, if
different machines need to configure settings differently (like
email), you are out of luck. There are some workarounds using git
rebase or branching, but they are too complicated for my
liking. Therefore, right now the only way to use this is to copy
_gitconfig_ to `~/.gitconfig` and edit manually the settings that need
to be changed. It sucks, but there is no easy solution to this right
now.

### Git without SSH

If ssh is not available for some reason, git may not work. In this
case, the http interface can be used. For example in github, this
would be some thing like `git clone
https://github.com/{user}/{project}.git`. The only problem with this
is that the password is requested every time. To avoid this, create a
*.netrc* file with the contents `machine <host> login <user> password
<pass>`. Don't forget to remove permissions with `chmod 600 .netrc`.

It is however a better idea to use SSH through a proxy.

### Proxy for Git

If you connect through a proxy, it may work if you set it up in the
shell config. Otherwise use `git config --global http.proxy
host:port`.

Note that if the url of the repository is written as something like
_https://user@github.com..._ (as github recommends), the _.netrc_
configuration may be ignored. This can be fixed by removing the user@
part from the url.

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
[https://rvm.beginrescueend.com/packages/zlib/]()).

It might happen that _readline_ does not work. If _irb_ gives a weird
error, follow the instructions in this
[http://stackoverflow.com/questions/4498919/problems-with-the-rails-console-rvm-and-readline](Stack
Overflow post).)

#### irb

Follow the instructions in `irbrc/README.textile`.

### emacsclient

To use _emacsclient_ properly, don't use the version that ships with
the OS. Link the good one with `sudo ln -s
/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
/usr/local/bin/emacsclient`.
