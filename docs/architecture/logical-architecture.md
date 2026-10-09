# Logical Architecture

## Design principle

The lab is segmented into four VLANs that mirror how a real enterprise zones its
network: management, security tooling, monitored production, and an isolated
attacker segment. This isn't cosmetic — every firewall rule, every log-shipping
path, and every "why does Zeek sit here" answer traces back to this diagram.

```
                                   INTERNET
                                       |
                              +--------+--------+
                              |   pfSense (WAN)  |
                              |   Firewall/Router |
                              +--------+--------+
                                       | LAN (trunk, VLANs below)
                    +------------------+------------------+
                    |                  |                   |
             +------+------+   +-------+-------+   +-------+-------+
             |  VLAN 10     |   |  VLAN 20      |   |  VLAN 30      |
             |  MGMT/OOB    |   |  SOC TOOLING  |   |  MONITORED    |
             |              |   |               |   |  (victim net) |
             | Proxmox host |   | Wazuh Manager |   | Win Server AD |
             | mgmt iface   |   | TheHive/Cortex|   | Win 11 client |
             |              |   | MISP          |   | Ubuntu client |
             |              |   | Shuffle SOAR  |   |               |
             |              |   | Velociraptor  |   | (Sysmon,      |
             |              |   |               |   |  Winlogbeat,  |
             |              |   |               |   |  Auditd,      |
             |              |   |               |   |  osquery all  |
             |              |   |               |   |  report ->    |
             |              |   |               |   |  VLAN 20)     |
             +--------------+   +---------------+   +-------+-------+
                                                             |
                                     +-----------------------+
                                     |  SPAN/mirror port
                              +------+-------+        +---------------+
                              | Zeek/Suricata |        |  VLAN 40      |
                              | (network IDS, |        |  ATTACKER     |
                              |  passive tap) |        |  Kali Linux   |
                              +---------------+        |  (isolated,   |
                                                        |  one-way to   |
                                                        |  VLAN 30 only)|
                                                        +---------------+
```

## Key design decisions

1. **Zeek/Suricata sit on a mirrored/SPAN interface off VLAN 30**, not inline —
   passive network monitoring, matching how most enterprise NIDS actually deploys.
2. **VLAN 40 (attacker) can only reach VLAN 30.** pfSense explicitly denies and
   logs any attempt from VLAN 40 toward VLAN 20 (SOC tooling) or VLAN 10 (mgmt).
   This prevents the red-team box from ever being able to touch the SIEM/SOAR stack.
3. **VLAN 20 (SOC tooling) is the most locked-down segment** — only log-forwarding
   ports (Wazuh agent 1514/1515) are allowed inbound from VLAN 30, and analyst
   access is allowed inbound only from VLAN 10.

## Operating-mode rotation (8GB RAM constraint)

Running every listed component simultaneously is not realistic on an 8GB host.
The lab uses a rotation model instead:

**Always-on core (~4GB budget, always running):**
- pfSense
- Wazuh (manager + indexer + dashboard, single-node, tuned heap)
- Ubuntu endpoint (persistent log source)

**Rotation groups (one active at a time, ~3-4GB each):**
- **Mode A** — AD + Detection Engineering: Windows Server AD DC, Windows 11 endpoint
- **Mode B** — Threat Hunting / Network: Zeek/Suricata sensor, Kali attacker
- **Mode C** — SOAR / Case Management: TheHive, Cortex, MISP, Shuffle (Docker)

**One-off / short-lived (spin up, run, tear down):**
- OpenVAS (run as a scan job)
- CrowdSec (run during specific brute-force simulations)
- Grafana/Prometheus (run for dashboard screenshots)

See `docs/phase-notes/phase2-infrastructure.md` for the rationale and
`scripts/bash/mode-a.sh` / `mode-b.sh` for the switching automation.
