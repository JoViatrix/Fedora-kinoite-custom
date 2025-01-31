#!/bin/bash

set -ouex pipefail

echo "Installing bitwarden"

wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=rpm" -O /tmp/bitwarden.rpm


mkdir -p /var/opt
dnf5 install -y /tmp/bitwarden.rpm
mv /var/opt/Bitwarden /usr/lib/opt/Bitwarden

cat >/usr/lib/tmpfiles.d/bitwarden.conf <<EOF
L /opt/Bitwarden - - - - /usr/lib/opt/Bitwarden
EOF