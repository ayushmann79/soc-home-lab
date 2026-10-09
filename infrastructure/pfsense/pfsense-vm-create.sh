#!/bin/bash
# Create the pfSense VM with one NIC per VLAN plus a WAN NIC
set -euo pipefail

qm create 100 \
  --name pfsense-fw \
  --memory 768 \
  --cores 1 \
  --net0 virtio,bridge=vmbr0,tag=10 \
  --net1 virtio,bridge=vmbr0,tag=20 \
  --net2 virtio,bridge=vmbr0,tag=30 \
  --net3 virtio,bridge=vmbr0,tag=40 \
  --net4 virtio,bridge=vmbr0 \
  --scsihw virtio-scsi-pci \
  --ostype other

echo "VM 100 (pfsense-fw) created. Attach pfSense ISO and boot to install."
echo "Interface mapping after install:"
echo "  net0 (tag 10) -> LAN (MGMT)      -> 10.10.10.1/24"
echo "  net1 (tag 20) -> OPT1 (SOC_TOOL) -> 10.10.20.1/24"
echo "  net2 (tag 30) -> OPT2 (MONITOR)  -> 10.10.30.1/24"
echo "  net3 (tag 40) -> OPT3 (ATTACKER) -> 10.10.40.1/24"
echo "  net4 (untagged) -> WAN"
