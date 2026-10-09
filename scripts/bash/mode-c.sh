#!/bin/bash
# Mode C: SOAR / Case Management (TheHive/Cortex/MISP/Shuffle host)
set -euo pipefail
qm start 121
echo "Mode C active: soc-tools VM up. Bring up containers with:"
echo "  docker compose -f docker/soc-tools/docker-compose.yml up -d"
