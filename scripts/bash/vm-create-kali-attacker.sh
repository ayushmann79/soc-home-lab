#!/bin/bash
set -euo pipefail
qm create 140 \
  --name kali-attacker \
  --memory 1536 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0,tag=40 \
  --scsihw virtio-scsi-pci \
  --ostype l26
qm set 140 --onboot 0
echo "VM 140 created (onboot disabled - Mode B only). Static IP 10.10.40.10/24."
