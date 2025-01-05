#!/bin/bash

set -ouex pipefail

echo "Installing xone"

dnf5 -y copr enable sentry/xone

RELEASE="$(rpm -E %fedora)"
KERNEL_FLAVOR=main
KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"

skopeo copy docker://ghcr.io/ublue-os/akmods:"${KERNEL_FLAVOR}"-"${RELEASE}"-"${QUALIFIED_KERNEL}" dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/

dnf5 install -y xone /tmp/rpms/kmods/*xone*.rpm

cat >/usr/lib/tmpfiles.d/xone_firmware.conf <<EOF
L /lib/firmware/xow_dongle.bin - - - - /var/lib/firmware/xow_dongle.bin
EOF

cp ./firmware.sh /usr/bin/xone-get-firmware.sh

dnf5 copr remove sentry/xone