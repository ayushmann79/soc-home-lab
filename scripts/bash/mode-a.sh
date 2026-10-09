#!/bin/bash
# Mode A: AD + Detection Engineering (Windows Server AD DC + Windows 11)
set -euo pipefail
qm stop 140 2>/dev/null || true   # ensure Kali is down
qm start 131                       # AD DC
sleep 30                           # let DC boot before joining traffic
qm start 132                       # Win11
echo "Mode A active: AD DC + Win11 endpoint up."
