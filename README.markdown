# Shell config

This project provides a set of defaults for bash, as well as custom
settings for each OS/Machine.

## Installation

Bash is available on most systems, so you will probably only need to
configure your own system. It should work as well on older versions of
bash.

1. Check out this directory and put it in ~/shell. If you want to use
another directory, you will need to edit the SHELL variable in bashrc.

2. Add the line ". ~/shell/bashrc" (or equivalent value of SHELL) to
the .bashrc file.

3. Link the inputrc file with "ln -s ~/shell/inputrc ~/.inputrc".

4. Add settings for a specific machine by creating a file in the users
directory with the name returned by the "ehostname" command. This file
can contain specific settings, like aliases for the folders in the
machine.

5. Check if your os is included by looking for the result of "uname
-s" in the bashrc file. If your os is not there, create a file and
link it from there.

6. You can also add completion files by putting them in the completion
folder.

## Structure

the bashrc file is where everything begins. It contains all the files
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
it to your ssh config with something like ln -s ~/shell/ssh/config
~/.ssh/config .

To log without a key follow this advice: [RSA without
pass](http://linuxproblem.org/art_9.html)

## Project initialization

### GIT

There are some functions to create new git repositories, synchronized
with a remote server. The prompt is modified to show the state of a
git repository, if we are in a folder that contains one.

### JAVA

There is also code to create new java projects, with some build and
project files (for ant/jdee, respectively).


## Directory logging

There are a couple of scripts to enable logging of the directories
that are being visited. This information is stored in a SQLite
database. To enable the logging, do the following:

NOTE: This functionality requires python, probably a recent one (2.5
should suffice).

1. Create the database by calling the build_logging_db. After this
point every change of directory will be stored in the database.

2. Add a cron job that runs the damp script. This reduces the
frequence counts, so that directories that have not been visited in a
while dissapear eventually.

For example this line sets the script to run every Sunday at 22.30:

crontab -e 30 22 * * 0 python ~/shell/python/directory_damp.py

After this, the go functions will be available. You can get the most
visited directories, and navigate to them easily, via the
go_frequency. To get the most recently visited ones, use go_recent.

Note that if you want the directory where the DB is saved, as defined
in the environment variable DIRLOGSDB, you should also edit the
get_db_path python function, which is defined in
directory_recent.py. This method cannot use it because it is called by
the cron job.
