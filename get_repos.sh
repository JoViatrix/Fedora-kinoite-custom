#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
cp /tmp/local_repos/*.repo /etc/yum.repos.d/
wget https://copr.fedorainfracloud.org/coprs/rok/cdemu/repo/fedora-$RELEASE/rok-cdemu-fedora-$RELEASE.repo -O /etc/yum.repos.d/rok-cdemu.repo
