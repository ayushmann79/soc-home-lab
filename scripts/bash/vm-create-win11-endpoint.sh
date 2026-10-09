#!/bin/bash
set -euo pipefail
qm create 132 \
  --name win11-endpoint \
  --memory 2048 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0,tag=30 \
  --scsihw virtio-scsi-pci \
  --ostype win11
# Windows 11 requires UEFI + TPM 2.0
qm set 132 --bios ovmf --machine q35
qm set 132 --efidisk0 local-lvm:1
qm set 132 --tpmstate0 local-lvm:4,version=v2.0
qm set 132 --onboot 0
echo "VM 132 created (onboot disabled - Mode A only)."
echo "Static IP: 10.10.30.20/24, DNS 10.10.30.10, join soclab.local once AD is up."
