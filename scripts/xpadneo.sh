#!/bin/bash

set -ouex pipefail

echo "Installing xpadneo"

dnf5 -y copr enable atim/xpadneo

dnf5 install -y xpadneo kmod-xpadneo

KERNEL_SUFFIX=""
KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

akmods --force --kernels "$KERNEL" --kmod xpadneo

cat >/etc/modules-load.d/xpadneo.conf <<EOF
hid_xpadneo
EOF

dnf5 copr remove atim/xpadneo



