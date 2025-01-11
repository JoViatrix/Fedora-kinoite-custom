#!/bin/bash

set -ouex pipefail

echo "Updating mesa"

dnf5 swap -y mesa-dri-drivers mesa-dri-drivers
dnf5 swap -y mesa-va-drivers mesa-va-drivers
dnf5 swap -y mesa-vulkan-drivers mesa-vulkan-drivers
