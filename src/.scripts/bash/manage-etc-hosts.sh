#!/usr/bin/env bash

hostsFile="/etc/hosts"

ip="127.0.0.1"

hostname="$2"

die() { exit 111; }
try() { "$@" || die "cannot $*"; }

removeHost() {
    if [ -n "$(grep -P "[[:space:]]$hostname" /etc/hosts)" ]; then
        try sudo sed -ie "/[[:space:]]$hostname/d" "$hostsFile"
    else
      :
    fi
}

addHost() {
    if [ -n "$(grep -P "[[:space:]]$hostname" /etc/hosts)" ]; then
      :
    else
        try printf "%s\t%s\n" "$ip" "$hostname" | sudo tee -a "$hostsFile" > /dev/null

        if [ -n "$(grep $hostname /etc/hosts)" ]; then
        else
            die
        fi
    fi
}

$@
