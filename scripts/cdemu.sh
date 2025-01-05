#!/bin/bash

set -ouex pipefail

echo "Installing cdemu"

dnf5 -y copr enable rok/cdemu

dnf5 install -y cdemu-client cdemu-daemon gcdemu

KERNEL_SUFFIX=""
KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

akmods --force --kernels "$KERNEL" --kmod vhba

modinfo /usr/lib/modules/${KERNEL}/extra/xpadneo/vhda.ko.xz > /dev/null \
|| (find /var/cache/akmods/vhda/ -name \*.log -print -exec cat {} \; && exit 1)

cat >/etc/modules-load.d/vhda.conf <<EOF
vhda
EOF

dnf5 copr remove rok/cdemu