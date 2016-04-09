# SSH Configuration

## SSH Profiles

You can add ssh profiles in the ssh/config file. You'll need to link
it to your ssh config with something like `ln -s ~/shell/ssh/config ~/.ssh/config` .

To log without a key follow this advice: [RSA without
pass](http://linuxproblem.org/art_9.html)

## SSH through proxy

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
be compiled and installed in the PATH. Instructions can
be found
[here](http://bent.latency.net/bent/git/goto-san-connect-1.85/src/connect.html#sec5);
use [this](http://dl.dropbox.com/u/3093385/connect.c) link for the program.
