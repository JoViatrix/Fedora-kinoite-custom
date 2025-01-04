#!/bin/bash

set -eoux pipefail

RELEASE="$(rpm -E %fedora)"
ls /tmp/
ls /tmp/local_repos/
cp /tmp/local_repos/*.repo /etc/yum.repos.d/
wget https://copr.fedorainfracloud.org/coprs/rok/cdemu/repo/fedora-$RELEASE/rok-cdemu-fedora-$RELEASE.repo -O /etc/yum.repos.d/rok-cdemu.repo
