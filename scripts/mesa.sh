#!/bin/bash

set -ouex pipefail

echo "Adding mesa extras"
dnf5 -y install mesa-libd3d mesa-libd3d.i686
