#!/bin/bash
set -euo pipefail
qm create 160 \
  --name velociraptor \
  --memory 512 \
  --cores 1 \
  --net0 virtio,bridge=vmbr0,tag=20 \
  --scsihw virtio-scsi-pci \
  --ostype l26
echo "VM 160 created. Install Ubuntu minimal, deploy Velociraptor server per docs/phase-notes/phase9-incident-response.md"
