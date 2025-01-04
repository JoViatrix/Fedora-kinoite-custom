#!/bin/bash

set -ouex pipefail

echo "Installing xone"

dnf5 -y copr enable sentry/xone

dnf5 install -y xone lpf-xone-firmware

#lpf approve xone-firmware
#lpf build xone-firmware
#lpf install -y xone-firmware

dnf5 copr remove sentry/xone