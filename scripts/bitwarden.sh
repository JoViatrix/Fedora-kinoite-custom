#!/bin/bash

set -ouex pipefail

echo "Installing bitwarden"

wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=rpm" -O /tmp/bitwarden.rpm


mkdir -p /var/opt
dnf5 install -y /tmp/bitwarden.rpm
mv /var/opt/Bitwarden /usr/lib/opt/Bitwarden

cat >/usr/lib/tmpfiles.d/bitwarden.conf <<EOF
L /opt/Bitwarden - - - - /usr/lib/opt/Bitwarden
EOF

echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE policyconfig PUBLIC
 "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/PolicyKit/1.0/policyconfig.dtd">

<policyconfig>
    <action id="com.bitwarden.Bitwarden.unlock">
      <description>Unlock Bitwarden</description>
      <message>Authenticate to unlock Bitwarden</message>
      <defaults>
        <allow_any>no</allow_any>
        <allow_inactive>no</allow_inactive>
        <allow_active>auth_self</allow_active>
      </defaults>
    </action>
</policyconfig>' > /usr/share/polkit-1/actions/com.bitwarden.Bitwarden.policy

chown root:root /usr/share/polkit-1/actions/com.bitwarden.Bitwarden.policy
chcon system_u:object_r:usr_t:s0 /usr/share/polkit-1/actions/com.bitwarden.Bitwarden.policy