# -*- mode: Shell-script-*-

#
# Settings for the machine 'ls004'
#

## ENV

export JAVA_HOME=/opt/jdk
export ANT_HOME=/opt/ant
export MAVEN_HOME=/opt/maven
export MONGODB_HOME=/opt/mongodb
export JACORB_HOME=/opt/jacorb
export JMETER_HOME=/opt/jmeter
export TOMCAT_HOME_GUEST=/opt/guest-tomcat
export TOMCAT_HOME_MEMBER=/opt/member-tomcat

export JRUBY_OPTS="--1.9 -J-Xmx2048m"
export JAVA_OPTS="$JAVA_OPTS -Djava.endorsed.dirs=$JACORB_HOME/lib"

path=(${JAVA_HOME}/bin ${ANT_HOME}/bin ${JMETER_HOME}/bin ${MONGODB_HOME}/bin ${MAVEN_HOME}/bin /opt/play $path)

export COMPUTERNAME=ls004
activate-proxy 10.0.175.40 3128

export LD_PRELOAD="${HOME}/stderred/lib64/stderred.so"

## DEFUNS

function ant_build() {
    cd build
    ant "$@"
    code=$?
    cd ..
    notify-send "build: $@ is finished"
    return $code
}

function redeploy_app_to_local() {
    cd ${WORKSPACE}/datingr5
    ant_build clean.web
    ant_build build.web -Divy=no
    ssh dev-dom9 '~/bin/restart_member_tomcat'
    notify-send "redeploy frontend finished"
}

function redeploy_guest_to_local() {
    cd ${WORKSPACE}/datingr5guest
    ant_build clean.web
    ant_build build.web -Divy=no
    ssh dev-dom9 '~/bin/restart_guest_tomcat'
    notify-send "redeploy guest finished"
}

function smart_ssh() {
    if [[ "$@" =~ intqm ]] && [[ ! "$@" =~ intqmbuild01 ]] ; then
        command ssh -t intqmbuild01 command ssh -t $@
    elif [[ "$@" =~ intsec ]] && [[ ! "$@" =~ intsecbe03 ]] ; then
        command ssh -t intsecbe03 command ssh -t $@
    elif [[ "$@" =~ int2sec ]] && [[ ! "$@" =~ int2secbe03 ]] ; then
        command ssh -t int2secbe03 command ssh -t $@
    elif [[ "$@" =~ int3sec ]] && [[ ! "$@" =~ int3secbe03 ]] ; then
        command ssh -t int3secbe03 command ssh -t $@
    else
        command ssh $@
    fi
}

# Convert an epoch from postgresql (stored in ms) to a human-readable
# date
function psql-to-date() {
    date --date "Jan 1, 1970 00:00:00 +0000 + $((${1:?No date given} / 1000)) seconds"
}

function slave-vnc() {
    vinagre ${1:?HostName is required}:5902:2 &
}

function cucumberify() {
    export CUCUMBER_SUFFIX=_cucumber && export RAILS_ENV="test" && export RACK_ENV="test"
}

function uncucumberify() {
    unset CUCUMBER_SUFFIX && unset RAILS_ENV && unset RACK_ENV
}

## ALIASES

# Workspace related
alias pub='publish_project'
alias build='ant_build'
alias lbuild='ant_build -f buildlocal.xml'
alias left='left_something_uncommited'
alias up='update_every_project'
alias redeploy='redeploy_app_to_local'
alias guest_redeploy='redeploy_guest_to_local'

# ACK That ignores build directories
alias a='ack-grep --ignore-dir=build --ignore-dir=bin'

# Remap ssh
alias ssh='smart_ssh'
compdef _ssh smart_ssh=ssh
