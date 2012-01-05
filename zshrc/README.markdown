# Z-shell config

This is a configuration for the z-shell.

## Installation

Zsh is usually available on most systems.

1. It is assumed that the parent _zshrc_ folder is under
_~/shell_. Change the __SHELL_DIR__ in the _zsh_ file if you want to
use another directory.

2. Run `ln -s ~/shell/zshrc/zsh ~/.zshrc` (modified for your
directory).

3. Add settings for a specific machine by creating a file in the
machine directory with the name returned by the _ehostname_
command. This file can contain specific settings, like aliases for the
folders in the machine.

4. Check if your os is included by looking for the result of `uname
-s` in the bashrc file. If your os is not there, create a file and
link it from there.

### Setting zsh as the default shell

Run: `chsh -s /bin/zsh`

### Oh-my-zsh

This configuration requires __Oh-my-zsh__. Clone it from:

* `git clone https://github.com/robbyrussell/oh-my-zsh.git` for the original
* `git clone git@github.com:sirech/oh-my-zsh.git` for my modified
  version. Make sure to use the _devel_ branch to get the latest changes.

Then set the _ZSH_ enviroment variable in the _zsh_ file to the folder
where you cloned the project.

### Zsh-Completions

The [Zsh-Completions](https://github.com/zsh-users/zsh-completions)
should be checked out under _~/shell/zshrc/completions_

## Structure

This configuration tries to leverage existing functionality from
_Oh-my-zsh_ as much as possible. This cannot be done in that
repository because the customizations for __OMZ__ are not stored in
the repository.

### Loading config

Configuration files are not loaded directly, but symlinked to the
_custom_ folder in __OMZ__, so that they will be loaded with it. A
prefix is appended to the symlink to ensure a concrete loading
order. The folders are loaded in the order:

config > os > machine > plugins

Inside each folder, the order can be specified by providing a
numerical prefix, like 01_first.zsh, 02_second.zsh, ...

### Config

Basic configurations are stored in the _config_ folder, like
environment variables.

### OS

Configuration specific to each operating system.

### Machine

Configuration for a machine with a name like the file name.

### Plugins

Plugins in the _plugins_ folder are linked to _custom/plugins_. They
are not loaded by default, just if they are included in the list of
plugins. Be sure to follow the conventions for them (e.g a plugin for
git would have a folder named git, with a file git.plugin.zsh inside).

## Updating to the last version

Given the dependencies of this configuration, simply checking out the
last version of this repository is not enough. The following steps
should be followed:

1. Pulling the last version of this repository.
2. Pulling the last version of _zsh-completions_, in the completions folder.
3. Pulling the last version of _Oh-my-zsh_. Covered by the
_git-sync-github-fork_ script.

The whole process is covered by the _update-shell_ script.
