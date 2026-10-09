#!/bin/bash
# Mode B: Threat Hunting / Network attacks (Kali attacker)
set -euo pipefail
qm stop 131 132 2>/dev/null || true
qm start 140
echo "Mode B active: Kali attacker up. Network sensor VM (150) should already be running."
