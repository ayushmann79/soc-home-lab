#!/bin/bash
set -euo pipefail
WAZUH_MANAGER="${1:-10.10.20.10}"

curl -o wazuh-agent.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.9.0-1_amd64.deb
WAZUH_MANAGER="$WAZUH_MANAGER" dpkg -i ./wazuh-agent.deb
systemctl enable --now wazuh-agent
echo "Agent installed, pointed at manager $WAZUH_MANAGER."
echo "Verify with: journalctl -u wazuh-agent -f"
