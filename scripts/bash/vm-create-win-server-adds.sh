#!/bin/bash
set -euo pipefail
qm create 131 \
  --name win-server-adds \
  --memory 2048 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0,tag=30 \
  --scsihw virtio-scsi-pci \
  --ostype win10
qm set 131 --onboot 0
echo "VM 131 created (onboot disabled - Mode A only). Attach Server 2022 ISO + VirtIO drivers."
echo "Static IP: 10.10.30.10/24. Run scripts/powershell/deploy-adds.ps1 after OS install."
