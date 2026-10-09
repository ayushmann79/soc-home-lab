# Traffic Mirroring Setup (software SPAN approximation)

No physical SPAN port exists on a single-host Proxmox lab. This mirrors
ingress traffic from a monitored VLAN's tap interface to the sensor VM's
second NIC using Linux `tc`. This is explicitly a software approximation of
a hardware TAP/SPAN port, not identical to it — worth noting as a documented
limitation rather than an oversight.

## One-time setup (per boot, since tap interfaces are ephemeral)

```bash
# Identify pfSense's OPT2 (VLAN 30) tap interface and the sensor VM's tap
tc qdisc add dev tap100i2 ingress

tc filter add dev tap100i2 parent ffff: \
  protocol all u32 match u32 0 0 \
  action mirred egress mirror dev tap150i0
```

## Persisting across reboots
Wrap the above in `scripts/bash/mirror-setup.sh` and call it from a systemd
oneshot unit (`mirror-setup.service`) that runs after both VMs (100, 150)
have started.
