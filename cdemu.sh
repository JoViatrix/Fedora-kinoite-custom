#!/bin/bash

set -ouex pipefail

echo "Installing cdemu"

dnf5 -y copr enable rok/cdemu

dnf5 install -y cdemu-client cdemu-daemon gcdemu

dnf5 copr remove rok/cdemu