#!/bin/bash
set -euo pipefail
qm create 121 \
  --name soc-tools \
  --memory 3072 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0,tag=20 \
  --scsihw virtio-scsi-pci \
  --ostype l26
qm set 121 --onboot 0
echo "VM 121 created (onboot disabled - Mode C only). Static IP 10.10.20.11/24."
echo "Install Docker + Compose, then: docker compose -f docker/soc-tools/docker-compose.yml up -d"
