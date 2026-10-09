#!/bin/bash
set -euo pipefail
qm create 120 \
  --name wazuh-siem \
  --memory 2560 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0,tag=20 \
  --scsihw virtio-scsi-pci \
  --ostype l26
echo "VM 120 created. Install Ubuntu Server 22.04 minimal, static IP 10.10.20.10/24."
echo "Then run: curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh && bash wazuh-install.sh -a"
