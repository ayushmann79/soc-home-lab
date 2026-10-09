#!/bin/bash
# Proxmox VE baseline setup: repo switch, updates, HA service disable
set -euo pipefail

sed -i 's/^deb/#deb/' /etc/apt/sources.list.d/pve-enterprise.list
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" \
  > /etc/apt/sources.list.d/pve-no-subscription.list

apt update && apt full-upgrade -y

# Disable HA/cluster services not needed for a single-node lab
systemctl disable --now pve-ha-lrm pve-ha-crm corosync 2>/dev/null || true

# Baseline RAM check - document this output in docs/phase-notes/phase2-baseline.md
free -h
