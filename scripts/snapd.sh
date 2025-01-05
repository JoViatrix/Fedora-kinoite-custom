#!/bin/bash

set -ouex pipefail

echo "Installing snapd"

dnf5 install snapd
systemctl enable snapd

sudo ln -s /var/lib/snapd/snap /snap
cat >/usr/lib/tmpfiles.d/snapd.conf <<EOF
L /snap - - - - /var/lib/snapd/snap
EOF