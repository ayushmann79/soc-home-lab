#!/bin/bash
# Points a Linux host's NTP client at pfSense (internal NTP authority)
set -euo pipefail
PFSENSE_GW="${1:-10.10.30.1}"

apt install -y chrony
cat <<EOF > /etc/chrony/chrony.conf
server ${PFSENSE_GW} iburst
EOF
systemctl restart chrony
chronyc sources
