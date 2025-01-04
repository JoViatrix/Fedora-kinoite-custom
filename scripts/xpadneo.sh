#!/bin/bash

set -ouex pipefail

echo "Installing xpadneo"

dnf5 -y copr enable atim/xpadneo

dnf5 install -y xpadneo

cat >/etc/modules-load.d/xpadneo.conf <<EOF
hid_xpadneo
EOF

dnf5 copr remove atim/xpadneo



