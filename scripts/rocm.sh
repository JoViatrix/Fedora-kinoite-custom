#!/bin/bash

set -ouex pipefail

echo "Installing latest rocm hip and opencl from AMD"

cat << EOF > /etc/yum.repos.d/rocm.repo
[ROCm-latest]
name=ROCm-latest
baseurl=https://repo.radeon.com/rocm/yum/latest/main
enabled=1
priority=50
gpgcheck=1
gpgkey=https://repo.radeon.com/rocm/rocm.gpg.key
EOF

dnf5 install -y rocm-hip rocm-opencl

rm -f /etc/yum.repos.d/rocm.repo