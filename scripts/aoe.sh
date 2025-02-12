#!/bin/bash

set -ouex pipefail

echo "Installing aoe"

dnf5 install -y aoetools

cat >/etc/modules-load.d/aoe.conf <<EOF
aoe
EOF

cat >/etc/modprobe.d/aoe.conf <<EOF
options aoe aoe_deadsecs=10
EOF