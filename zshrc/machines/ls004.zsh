# -*- mode: Shell-script-*-

#
# Settings for the machine 'ls004'
#

## LOADING STUFF

. ~/.rvm/scripts/rvm

## ENV

export JAVA_HOME=/opt/jdk
export ANT_HOME=/opt/ant
export MAVEN_HOME=/opt/maven
export MONGODB_HOME=/opt/mongodb
export JACORB_HOME=/opt/jacorb
export JMETER_HOME=/opt/jmeter
export TOMCAT_HOME_GUEST=/opt/guest-tomcat
export TOMCAT_HOME_MEMBER=/opt/member-tomcat
export RSENSE_HOME=/opt/rsense

export JAVA_OPTS="$JAVA_OPTS -Djava.endorsed.dirs=$JACORB_HOME/lib"

path=($path ${JAVA_HOME}/bin ${ANT_HOME}/bin ${JMETER_HOME}/bin ${MONGODB_HOME}/bin ${MAVEN_HOME}/bin /opt/play)

export COMPUTERNAME=ls004
export PROXY_HOST=10.0.175.40
export PROXY_PORT=3128
export http_proxy=http://$PROXY_HOST:$PROXY_PORT/
export HTTP_PROXY=${http_proxy}
export GIT_PROXY_COMMAND=git-proxy-cmd

export WORKSPACE=${HOME}/workspace

export LD_PRELOAD="${HOME}/stderred/lib64/stderred.so"

## DEFUNS

function ant_build() {
    cd build
    ant "$@"
    code=$?
    cd ..
    return $code
}

function publish_project() {

    local jarFile
    local oldJar

    ant_build dist.publish

    if [ -d dist ] ; then

        jarFile=$(basename $(find dist/ -name *.jar))
        echo $jarFile

        for project in ../* ; do
            oldJar=${project}/lib/${jarFile}
            if [ -d ${project}/lib ] && [ -f "$oldJar" ]; then
                cp dist/$jarFile $oldJar
            fi
        done

    fi
}

function left_something_uncommited() {
    local project

    pushd $WORKSPACE > /dev/null

    for project in * ; do
        if [ -d ${project}/.svn ] && [ -n "$(grep 'svn://develop.internal.friendscout24.de/dev' ${project}/.svn/entries)" ] ; then
            if [ -n "$(svn status -q $project)" ] ; then
                echo "$project has something uncommitted"
            fi
        fi
    done

    popd > /dev/null
}

function update_every_project() {
    local project

    pushd $WORKSPACE > /dev/null

    for project in * ; do
        if [ -d ${project}/.svn ] && [ -n "$(grep 'svn://develop.internal.friendscout24.de/dev' ${project}/.svn/entries)" ] ; then
            echo "project: $project"
            svnu $project
        fi
    done

    popd > /dev/null
}

function redeploy_app_to_local() {
    cd ${WORKSPACE}/datingr5
    ant_build clean.web
    ant_build build.web -Divy=no
    ssh dev-dom9 '~/bin/restart_member_tomcat'
}

function redeploy_guest_to_local() {
    cd ${WORKSPACE}/datingr5guest
    ant_build clean.web
    ant_build build.web -Divy=no
    ssh dev-dom9 '~/bin/restart_guest_tomcat'
}

function smart_ssh() {
    if [[ "$@" =~ intqm ]] && [[ ! "$@" =~ intqmbuild01 ]] ; then
        command ssh -t intqmbuild01 command ssh -t $@
    else
        command ssh $@
    fi
}

function migrate() {
    repo=$1

    if [ -z "$repo" ] || [ ! -d $repo/.svn ] ; then
        echo "No valid svn repository given"
        exit 1
    fi

    url=`grep svn $repo/.svn/entries | head -n 1`
    # mv $repo old-svn
    git svn clone "$url" test
    echo "git svn clone $url $repo"
}

## ALIASES

# common dirs
alias gospace="cd $WORKSPACE"

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
