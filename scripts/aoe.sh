#!/bin/bash

set -ouex pipefail

echo "Installing aoe"

dnf5 install -y aoetools

cat >/etc/modules-load.d/aoe.conf <<EOF
aoe
EOF