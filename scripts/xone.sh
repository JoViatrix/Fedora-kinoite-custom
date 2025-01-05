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

cat >/usr/local/bin/xone-get-firmware.sh <<EOF
#!/usr/bin/env sh

# This script is based on https://github.com/medusalix/xone/blob/master/install.sh. Thx to all contributors of xone!

set -eu

if [ "$(id -u)" -ne 0 ]; then
    echo 'This script must be run as root!' >&2
    exit 1
fi

if ! [ -x "$(command -v curl)" ]; then
    echo 'This script requires curl!' >&2
    exit 1
fi

if ! [ -x "$(command -v cabextract)" ]; then
    echo 'This script requires cabextract!' >&2
    exit 1
fi

if [ "${1:-}" != --skip-disclaimer ]; then
    echo "The firmware for the wireless dongle is subject to Microsoft's Terms of Use:"
    echo 'https://www.microsoft.com/en-us/legal/terms-of-use'
    echo
    echo 'Press enter to continue!'
    read -r _
fi

driver_url='http://download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/07/1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e.cab'
firmware_hash='48084d9fa53b9bb04358f3bb127b7495dc8f7bb0b3ca1437bd24ef2b6eabdf66'

curl -L -o driver.cab "$driver_url"
cabextract -F FW_ACC_00U.bin driver.cab
echo "$firmware_hash" FW_ACC_00U.bin | sha256sum -c
mkdir -p /var/lib/firmware
mv FW_ACC_00U.bin /var/lib/firmware/xow_dongle.bin
rm driver.cab
EOF

chmod +x /usr/local/bin/xone-get-firmware.sh

dnf5 copr remove sentry/xone