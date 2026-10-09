# Phase 2: Infrastructure

## Objectives
- Install and harden Proxmox VE
- Configure VLAN-aware bridge networking
- Deploy pfSense as router/firewall for all 4 VLANs
- Configure inter-VLAN firewall rules

## 8GB RAM allocation decision

The single biggest RAM save: running Wazuh's own manager+indexer+dashboard
instead of Wazuh PLUS a separate full Elastic Stack. This cuts the requirement
by roughly 2GB+ (a standalone ES cluster typically wants its own multi-GB heap).

### Always-on core (~4GB)
| Component | RAM | Why always-on |
|---|---|---|
| pfSense | 768MB | Network backbone |
| Wazuh (single-node) | 2.5GB | SIEM spine |
| Ubuntu endpoint | 512MB | Persistent log source |
| Proxmox host overhead | ~4GB reserved | Host OS, safety margin |

### Rotation groups (one active at a time)
- **Mode A** (~4GB): Windows Server AD DC (2GB) + Windows 11 endpoint (2GB)
- **Mode B** (~3GB): Zeek/Suricata sensor (1.5GB) + Kali attacker (1.5GB)
- **Mode C** (~3GB): TheHive/Cortex/MISP/Shuffle consolidated Docker VM (3GB)

### One-off / short-lived
- OpenVAS — run as a scan job, not persistent
- CrowdSec — run during specific brute-force simulations
- Grafana/Prometheus — run for dashboard screenshot capture

## Proxmox install notes
- Filesystem: **ext4, not ZFS** — ZFS ARC cache competes directly with VM RAM
  at this host size
- Disable enterprise repo, enable no-subscription repo
- Disable HA/corosync services not needed for a single-node lab

```bash
sed -i 's/^deb/#deb/' /etc/apt/sources.list.d/pve-enterprise.list
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" \
  > /etc/apt/sources.list.d/pve-no-subscription.list
apt update && apt full-upgrade -y
systemctl disable --now pve-ha-lrm pve-ha-crm corosync 2>/dev/null
```

## Networking
Single VLAN-aware Linux bridge (`vmbr0`) on the host — VMs get tagged into
VLANs 10/20/30/40 purely in software. See `infrastructure/proxmox/interfaces`.

## pfSense deployment
See `infrastructure/pfsense/pfsense-vm-create.sh` for the VM creation command
and `infrastructure/pfsense/firewall-rules.md` for the full rule set.

## Verification
- pfSense WebGUI reachable from VLAN 10
- All 4 VLAN interfaces assigned and enabled
- VLAN 40 -> VLAN 20 deny rule confirmed logging blocked attempts
