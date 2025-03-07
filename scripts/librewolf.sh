#!/bin/bash

set -ouex pipefail

echo "Installing librewolf"

dnf5 config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo --save-filename=librewolf.repo

dnf5 install -y librewolf

rm -f /etc/yum.repos.d/librewolf.repo
