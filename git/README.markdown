# Git Configuration

## gitconfig

With git you can set a global configuration file, which contains
aliases, color settings and other useful things. Such a file is
included here, named _gitconfig_. The problem is, that as of Jan 2011,
there is no way to include other files in this config. Therefore, if
different machines need to configure settings differently (like
email), you are out of luck. To fix this, put the specific settings in
the file `~/.secrets`. An example is found in _secrets.example_. Then,
link the configuration with:

`ln -s ~/shell/git/gitconfig ~/.gitconfig`

## gitignore

A global _gitignore_ with sensible defaults is provided. To use, link
it with:

`ln -s ~/shell/git/gitignore ~/.gitignore`

## Gitk

[Gitk](ftp://ftp.kernel.org/pub/software/scm/git/docs/gitk.html) is a
graphical history viewer for git. It is however pretty ugly out of the
box, but that can be fixed.

* Mac OS X: An alias is included to use the native Tk

* Linux:

    # Adapt to latest version
    sudo apt-get install tk8.5
    # Type the number that corresponds to the tk version
    sudo update-alternatives --config wish

Additionally, a __gitk__ file is included that can be used as a base
for the `~/.gitk` file. Note that this file include specific settings
for each machine, like the size of the screen and position of each
window, so it cannot be simply linked and reused. This file requires
the __Inconsolata__ font to be installed in your system.

## Git without SSH

If ssh is not available for some reason, git may not work. In this
case, the http interface can be used. For example in github, this
would be some thing like `git clone
https://github.com/{user}/{project}.git`. The only problem with this
is that the password is requested every time. To avoid this, create a
*.netrc* file with the contents `machine <host> login <user> password
<pass>`. Don't forget to remove permissions with `chmod 600 .netrc`.

It is however a better idea to use SSH through a proxy.

## Proxy for Git

If you connect through a proxy, it may work if you set it up in the
shell config. Otherwise use `git config --global http.proxy
host:port`.

Note that if the url of the repository is written as something like
_https://user@github.com..._ (as github recommends), the _.netrc_
configuration may be ignored. This can be fixed by removing the user@
part from the url.
