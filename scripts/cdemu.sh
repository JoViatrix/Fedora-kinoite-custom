#!/bin/bash

set -ouex pipefail

echo "Installing cdemu"

dnf5 -y copr enable rok/cdemu

dnf5 install -y cdemu-client cdemu-daemon gcdemu

akmods --force --kernels "$(rpm -q kernel)" --kmod vhba

cat >/etc/modules-load.d/vhda.conf <<EOF
vhda
EOF

dnf5 copr remove rok/cdemu