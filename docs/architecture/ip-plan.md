# IP Addressing Plan

## VLANs

| VLAN | Purpose | Subnet | Gateway |
|---|---|---|---|
| 10 | Management/OOB | 10.10.10.0/24 | 10.10.10.1 |
| 20 | SOC Tooling | 10.10.20.0/24 | 10.10.20.1 |
| 30 | Monitored/Production | 10.10.30.0/24 | 10.10.30.1 |
| 40 | Attacker (isolated) | 10.10.40.0/24 | 10.10.40.1 |

## Static host assignments

| Host | VLAN | IP | Proxmox VMID |
|---|---|---|---|
| pfSense (all LAN interfaces) | all | .1 in each subnet | 100 |
| Proxmox host mgmt | 10 | 10.10.10.10 | — |
| Wazuh Manager + Indexer + Dashboard | 20 | 10.10.20.10 | 120 |
| SOC Tools (TheHive/Cortex/MISP/Shuffle, Docker host) | 20 | 10.10.20.11 | 121 |
| Velociraptor server | 20 | 10.10.20.x | 160 |
| Windows Server AD DC | 30 | 10.10.30.10 | 131 |
| Windows 11 endpoint | 30 | 10.10.30.20 | 132 |
| Ubuntu endpoint | 30 | 10.10.30.21 | 130 |
| Zeek/Suricata sensor | 30 (mirror) | 10.10.30.5 | 150 |
| Kali attacker | 40 | 10.10.40.10 | 140 |

## Firewall rules summary (enforced on pfSense)

**Interface OPT3 (ATTACKER, VLAN 40):**
1. Allow VLAN 40 → VLAN 30 (any) — Kali needs to reach victims
2. Deny VLAN 40 → VLAN 20 (logged) — attacker can never reach SOC tooling
3. Deny VLAN 40 → VLAN 10 (logged) — attacker can never reach management
4. Allow VLAN 40 → WAN — attacker tooling/updates only

**Interface OPT1 (SOC_TOOLING, VLAN 20):**
1. Allow VLAN 30 → 10.10.20.10 on ports 1514/1515 (Wazuh agent enrollment/events) only
2. Allow VLAN 10 → 10.10.20.10:443 (dashboard) and 10.10.20.11:9000/9001 (TheHive/Cortex)
3. Deny all else inbound to VLAN 20 (default deny, logged)

**Interface OPT2 (MONITORED, VLAN 30):**
1. Allow VLAN 10 → VLAN 30 (management access)
2. Allow VLAN 40 → VLAN 30 (attacker exercises)
3. Allow VLAN 30 → VLAN 20 (outbound log shipping)

All deny rules have logging enabled — these logs feed Suricata/Zeek correlation
and provide direct evidence for the "segmentation enforcement" portfolio screenshot.
