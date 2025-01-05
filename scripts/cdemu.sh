#!/bin/bash

set -ouex pipefail

echo "Installing cdemu"

dnf5 -y copr enable rok/cdemu

dnf5 install -y cdemu-client cdemu-daemon gcdemu

KERNEL_SUFFIX=""
KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

akmods --force --kernels "$KERNEL" --kmod vhba

cat >/etc/modules-load.d/vhda.conf <<EOF
vhda
EOF

dnf5 copr remove rok/cdemu