#!/bin/bash

set -ouex pipefail

echo "Installing k3b"

dnf5 install -y k3b cdrskin flac