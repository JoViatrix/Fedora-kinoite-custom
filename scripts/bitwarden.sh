#!/bin/bash

set -ouex pipefail

echo "Installing bitwarden"

wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=rpm" -O /tmp/bitwarden.rpm

dnf5 install -y /tmp/bitwarden.rpm