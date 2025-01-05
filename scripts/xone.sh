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

dnf5 install -y xone lpf-xone-firmware /tmp/rpms/kmods/*xone*.rpm

#lpf approve xone-firmware
#lpf build xone-firmware
#lpf install -y xone-firmware

dnf5 copr remove sentry/xone