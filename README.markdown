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

3. Link the _inputrc_ file with `ln -s ~/shell/inputrc ~/.inputrc`.

4. Link the _vimrc_ file with `ln -s ~/shell/vimrc ~/.vimrc`.

5. Add settings for a specific machine by creating a file in the users
directory with the name returned by the _ehostname_ command. This file
can contain specific settings, like aliases for the folders in the
machine.

6. Check if your os is included by looking for the result of `uname
-s` in the bashrc file. If your os is not there, create a file and
link it from there.

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
