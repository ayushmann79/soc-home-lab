#!/bin/bash
# Stop everything except the always-on core (pfSense 100, Ubuntu endpoint 130, Wazuh 120)
set -euo pipefail
qm stop 131 132 140 121 150 160 2>/dev/null || true
echo "Rotation VMs stopped. Always-on core (pfSense, Wazuh, Ubuntu endpoint) left running."
