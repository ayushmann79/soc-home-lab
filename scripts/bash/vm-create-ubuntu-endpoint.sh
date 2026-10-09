#!/bin/bash
set -euo pipefail
qm create 130 \
  --name ubuntu-endpoint \
  --memory 512 \
  --cores 1 \
  --net0 virtio,bridge=vmbr0,tag=30 \
  --scsihw virtio-scsi-pci \
  --ostype l26
echo "VM 130 created. Install Ubuntu Server 22.04 minimal, static IP 10.10.30.21/24."
