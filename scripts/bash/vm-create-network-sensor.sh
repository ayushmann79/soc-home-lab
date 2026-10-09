#!/bin/bash
set -euo pipefail
qm create 150 \
  --name network-sensor \
  --memory 1024 \
  --cores 1 \
  --net0 virtio,bridge=vmbr0,tag=30 \
  --scsihw virtio-scsi-pci \
  --ostype l26
# Second NIC, untagged, used as the mirror target for Zeek/Suricata
qm set 150 --net1 virtio,bridge=vmbr0
echo "VM 150 created. Install Ubuntu Server minimal + zeek + suricata."
echo "Confirm the tap150i0 interface name for the mirror rule in infrastructure/proxmox/mirror-setup.md"
