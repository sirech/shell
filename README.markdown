# Shell config

This project provides a set of defaults for bash, as well as custom
settings for each OS/Machine.

## Installation

Bash is available on most systems, so you will probably only need to
configure your own system. It should work as well on older versions of
bash.

1. Check out this directory and put it in _~/shell_. If you want to use
another directory, you will need to edit the __SHELL__ variable in bashrc.

2. Add the line `. ~/shell/bashrc` (or equivalent value of __SHELL__) to
the _.bashrc_ file.

3. Add settings for a specific machine by creating a file in the users
directory with the name returned by the _ehostname_ command. This file
can contain specific settings, like aliases for the folders in the
machine.

4. Check if your os is included by looking for the result of `uname
-s` in the bashrc file. If your os is not there, create a file and
link it from there.

### Configuration files

There are configuration files for some common programs. To use them,
link them with something like:

`ln -s ~/shell/progrc ~/.progrc`

where _progrc_ is one of:

 * ackrc
 * inputrc
 * screenrc
 * vimrc

### Mac OS X

1. To use _emacsclient_ properly, don't use the version that ships
with the OS. Link the good one with `sudo ln -s
/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
/usr/local/bin/emacsclient`.

### Completion

Any file added to the completion folder will be used in case that
bash\_completion is available. Installing bash\_completion can be done
with a package manager (apt,macports,cygwin), and then by setting the
_BASH\_COMPLETION_ environment variable. Default values are provided
for each os.

Additionally, completions are generated for every alias that allows
so.

For reference, here is the origin of some of the files:

- (j)ruby, gem, rails, rake:
  [https://github.com/mernen/completion-ruby]()

### ACK

_Very_ useful.

* Mac OS X: `sudo port install p5-app-ack`

* Linux: `apt-get install ack-grep`

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


## Structure

the _bashrc_ file is where everything begins. It contains all the files
that will be loaded, plus the machine/os specific settings, as well as
the additional completion files.

The functionality is separated across the following files and folders,
with the root in the bash folder:

* env: Basic environment variables.

* config: Colors, prompt.

* defuns: Utility functions.

* aliases: Aliases to simplify some commands.

Also:

* macosx|cygwin|linux: Settings for specific operating systems.
* users : Folder with settings for specific machines.
* completion: Folder with completion files for specific programs.

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

If ssh is not available for some reason (like a proxy), git may not
work. In this case, the http interface can be used. For example in
github, this would be some thing like `git clone
https://github.com/{user}/{project}.git`. The only problem with
this is that the password is requested every time. To avoid this,
create a *.netrc* file with the contents `machine <host> login <user>
password <pass>`. Don't forget to remove permissions with `chmod 600
.netrc`.

### Proxy for Git

If you connect through a proxy, it may work if you set it up in the
shell config. Otherwise use `git config --global http.proxy
host:port`.

Note that if the url of the repository is written as something like
_https://user@github.com..._ (as github recommends), the _.netrc_
configuration may be ignored. This can be fixed by removing the user@
part from the url.

## Project initialization

### JAVA

There is also code to create new java projects, with some build and
project files (for ant/jdee, respectively).


## Directory logging

There are a couple of scripts to enable logging of the directories
that are being visited. This information is stored in a SQLite
database. To enable the logging, do the following:

NOTE: This functionality requires python, probably a recent one (2.5
should suffice).

1. Create the database by calling the *build_logging_db*. After this
point every change of directory will be stored in the database.

2. Add a cron job that runs the damp script. This reduces the
frequence counts, so that directories that have not been visited in a
while dissapear eventually.

For example this line sets the script to run every Sunday at 22.30:

`crontab -e 30 22 * * 0 python ~/shell/python/directory_damp.py`

After this, the go functions will be available. You can get the most
visited directories, and navigate to them easily, via the
*go_frequency*. To get the most recently visited ones, use *go_recent*.

Note that if you want the directory where the DB is saved, as defined
in the environment variable DIRLOGSDB, you should also edit the
*get_db_path* python function, which is defined in
directory_recent.py. This method cannot use it because it is called by
the cron job.
