# Bash config

This a set of defaults and settings for the bash shell, extending its
functionality as well as changing the presentation. Extra
configuration is supported for multiple OSes as well as machine
specific settings.

## Installation

Bash is available on most systems, so you will probably only need to
configure your own system. It should work as well on older versions of
bash.

1. This instructions assume that the directory containing the _bashrc_
 folder is located under _~/shell_. If you want to use another
 directory, you will need to edit the __SHELL_DIR__ variable in the
 _bash.sh_ file.

2. Add the line `. ~/shell/bashrc/bash.sh` to the _.bashrc_ file in
your user root directory.

3. Add settings for a specific machine by creating a file in the users
directory with the name returned by the _ehostname_ command. This file
can contain specific settings, like aliases for the folders in the
machine.

4. Check if your os is included by looking for the result of `uname
-s` in the bashrc file. If your os is not there, create a file and
link it from there.

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
  [](https://github.com/mernen/completion-ruby)

## Structure

the _bash.sh_ file is where everything begins. It contains all the files
that will be loaded, plus the machine/os specific settings, as well as
the additional completion files.

The functionality is separated across the following files and folders:

* env: Basic environment variables.

* config: Colors, prompt.

* defuns: Utility functions.

* aliases: Aliases to simplify some commands.

Also:

* os (macosx|cygwin|linux): Folder with settings for specific operating systems.
* users : Folder with settings for specific machines.
* completion: Folder with completion files for specific programs.

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
