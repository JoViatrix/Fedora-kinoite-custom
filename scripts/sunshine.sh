#!/bin/bash

set -ouex pipefail

echo "Installing Sunshine"

dnf5 -y copr enable lizardbyte/beta

dnf5 install -y sunshine

dnf5 copr remove lizardbyte/beta