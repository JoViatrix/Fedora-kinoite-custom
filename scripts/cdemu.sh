#!/bin/bash

set -ouex pipefail

echo "Installing cdemu"

dnf5 -y copr enable rok/cdemu

rpm-ostree install --idempotent cdemu-client cdemu-daemon gcdemu

cat >/etc/modules-load.d/vhda.conf <<EOF
vhda
EOF

dnf5 copr remove rok/cdemu