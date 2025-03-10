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

# rpm-ostree install kernel-devel-matched

# Uninstall packages

dnf5 remove -y kate firefox firefox-langpacks

# Install librewolf
./librewolf.sh

# Install wine staging from winehq.org
./winehq.sh

# Install bitwarden

./bitwarden.sh

# Install dosbox

dnf5 install -y dosbox

# Install virt-manager and qemu-kvm
dnf5 install -y virt-manager virt-install libvirt-daemon-kvm libvirt-daemon-config-network qemu-system-aarch64 qemu-system-riscv

# Install cdemu module and gui
./cdemu.sh

# Install rocm hip and opencl
./rocm.sh

# Installing xone and its firmware

./xone.sh

# Install xpadneo

./xpadneo.sh

# Install k3b

./k3b.sh

# Install sunshine

./sunshine.sh

# Install Nextcloud client

dnf5 install -y nextcloud-client-dolphin

# Install steam and tools

dnf5 install -y steam mangohud gamescope

# Install heroic

./heroic.sh

# Install zerotier-one
dnf5 install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm
dnf5 install -y zerotier-one

# Install additonal codecs multimedia group

dnf5 group install -y multimedia

dnf5 remove -y rpmfusion-free-release rpmfusion-nonfree-release

# Install aoe

./aoe.sh

# Install misc packages

dnf5 install -y btrbk corectrl waydroid ddrescue obs-studio piper innoextract thunderbird

# Update mesa

./mesa.sh

# Install Klassy theme

# ./klassy.sh
