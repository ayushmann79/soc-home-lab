#!/bin/bash
# Installs Zeek + Suricata on the network-sensor VM (150) and points them at
# the mirror interface (eth1) set up per docs/phase-notes/phase4-networking.md
set -euo pipefail

apt update
apt install -y zeek suricata

# Zeek: listen on the mirror NIC
mkdir -p /opt/zeek/etc
cat <<EOF > /opt/zeek/etc/node.cfg
[zeek]
type=standalone
host=localhost
interface=eth1
EOF

# Suricata: af-packet on the mirror NIC
sed -i 's/interface: eth0/interface: eth1/' /etc/suricata/suricata.yaml || true
suricata-update
systemctl restart suricata

echo "Zeek and Suricata configured on mirror interface eth1."
echo "Register both as Wazuh agents and add the localfile blocks in"
echo "agents/auditd/wazuh-agent-ossec-conf-snippets.xml to ossec.conf."
