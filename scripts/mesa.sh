#!/bin/bash

set -ouex pipefail

echo "Updating mesa"

dnf5 update -y mesa-* vulkan-*