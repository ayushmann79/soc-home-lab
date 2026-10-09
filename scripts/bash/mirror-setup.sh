#!/bin/bash
# Re-applies the tc mirred mirroring rule after reboot (tap interfaces are ephemeral)
# Intended to be called from a systemd oneshot unit after VMs 100 and 150 are up.
set -euo pipefail

SOURCE_TAP="tap100i2"   # pfSense OPT2 (VLAN 30) interface
TARGET_TAP="tap150i0"   # network-sensor VM's primary NIC

tc qdisc add dev "$SOURCE_TAP" ingress 2>/dev/null || true
tc filter add dev "$SOURCE_TAP" parent ffff: \
  protocol all u32 match u32 0 0 \
  action mirred egress mirror dev "$TARGET_TAP"

echo "Mirror rule applied: $SOURCE_TAP -> $TARGET_TAP"
