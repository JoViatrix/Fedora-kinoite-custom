#!/bin/bash

set -ouex pipefail

echo "Installing Wine from winehq.org"

dnf5 config-manager addrepo --from-repofile=https://dl.winehq.org/wine-builds/fedora/41/winehq.repo --save-filename=winehq.repo

mkdir -p /var/opt
dnf5 install -y winehq-staging
mv /var/opt/wine-staging /usr/lib/opt/wine-staging
cat >/usr/lib/tmpfiles.d/winehq.conf <<EOF
L /opt/wine-staging - - - - /usr/lib/opt/wine-staging
EOF

rm -f /etc/yum.repos.d/winehq.repo
