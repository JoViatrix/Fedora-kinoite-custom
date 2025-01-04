#!/bin/bash

set -ouex pipefail

echo "Installing heroic"

dnf5 -y copr enable atim/heroic-games-launcher

dnf5 install -y heroic-games-launcher-bin cabextract

dnf5 copr remove atim/heroic-games-launcher