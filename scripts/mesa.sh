#!/bin/bash

set -ouex pipefail

echo "Updating mesa"

dnf5 -y copr enable che/mesa

dnf5 update -y --repo=copr:copr.fedorainfracloud.org:che:mesa,copr:copr.fedorainfracloud.org:che:mesa:ml

dnf5 copr remove che/mesa
