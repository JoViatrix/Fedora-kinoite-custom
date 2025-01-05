#!/bin/bash

set -ouex pipefail

echo "Installing xpadneo"

dnf5 -y copr enable atim/xpadneo

dnf5 install -y xpadneo

KERNEL_SUFFIX=""
KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

akmods --force --kernels "$KERNEL" --kmod xpadneo

modinfo /usr/lib/modules/${KERNEL}/extra/xpadneo/hid-xpadneo.ko.xz > /dev/null \
|| (find /var/cache/akmods/xpadneo/ -name \*.log -print -exec cat {} \; && exit 1)

cat >/etc/modules-load.d/xpadneo.conf <<EOF
hid_xpadneo
EOF

dnf5 copr remove atim/xpadneo



