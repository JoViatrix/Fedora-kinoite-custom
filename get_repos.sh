#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
cp /tmp/local_repos/*.repo /etc/yum.repos.d/
dnf5 -y copr enable rok/cdemu
dnf5 -y copr enable sentry/xone