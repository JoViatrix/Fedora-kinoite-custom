#!/bin/bash

set -ouex pipefail

echo "Installing snapd"

rpm-ostree install snapd
systemctl enable snapd

# ln -s /var/lib/snapd/snap /snap
# cat >/usr/lib/tmpfiles.d/snapd.conf <<EOF
# L /snap - - - - ../var/lib/snapd/snap
# EOF
