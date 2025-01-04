#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

#### Example for enabling a System Unit File
# systemctl enable podman.socket

cd "$(dirname "$0")"

dnf5 install -y kernel-devel-matched

# Install wine staging from winehq.org
./winehq.sh

# Install virt-manager and qemu-kvm
dnf5 install -y virt-manager virt-install libvirt-daemon-kvm libvirt-daemon-config-network

# Install cdemu module and gui
./cdemu.sh

# Install prorietary rocm hip and opencl from AMD
./rocm.sh

# Installing xone and its firmware

./xone.sh

# Install xpadneo

./xpadneo.sh

# Install k3b

./k3b.sh

# Install snapd

dnf5 install -y snapd

dnf5 install -y nextcloud-client-dolphin