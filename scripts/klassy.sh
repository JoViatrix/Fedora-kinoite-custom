#!/bin/bash

set -ouex pipefail

echo "Installing Klassy plasma theme"

dnf5 config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:paul4us/Fedora_41/home:paul4us.repo --save-filename=klassy.repo

dnf5 install -y klassy

rm -f /etc/yum.repos.d/klassy.repo