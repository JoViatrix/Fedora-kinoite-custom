#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
<<<<<<< HEAD
# rpm-ostree install screen
=======
rpm-ostree install screen
>>>>>>> cf59fdf95fac4e3193e68f8a79b2b6497549200c

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File
<<<<<<< HEAD
# systemctl enable podman.socket

rpm-ostree install kernel-devel winehq-staging cdemu-client cdemu-daemon gcdemu snapd
=======

systemctl enable podman.socket
>>>>>>> cf59fdf95fac4e3193e68f8a79b2b6497549200c
