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
/tmp/get_repos.sh
dnf5 install -y kernel-devel-matched

# Install wine staging from winehq.org
/tmp/winehq.sh

# Install virt-manager and qemu-kvm
dnf5 install -y virt-manager virt-install libvirt-daemon-kvm libvirt-daemon-config-network

# Install cdemu module and gui
dnf5 install -y install cdemu-client cdemu-daemon gcdemu

# Install prorietary rocm hip and opencl

dnf5 install -y rocm-hip rocm-opencl

# Installing xone and its firmware

dnf install -y xone lpf-xone-firmware
lpf approve xone-firmware
lpf build xone-firmware
lpf install -y xone-firmware

# Install snapd

dnf5 install -y snapd

dnf5 install -y nextcloud-client-dolphin