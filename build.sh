#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# rpm-ostree install screen

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File
# systemctl enable podman.socket
/tmp/get_repos.sh
rpm-ostree install kernel-devel-matched --reboot
rpm-ostree install winehq-staging snapd nextcloud-client-dolphin

# Install virt-manager and qemu-kvm
rpm-ostree install virt-manager virt-install libvirt-daemon-kvm libvirt-daemon-config-network

# Install cdemu module and gui
rpm-ostree install cdemu-client cdemu-daemon gcdemu