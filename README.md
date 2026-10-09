# SOC Home Lab — Enterprise-Style Security Operations Center

A segmented, resource-constrained (8GB RAM) home lab built to mirror real enterprise
SOC architecture: network segmentation, a Wazuh SIEM, a Sigma-based detection-as-code
pipeline mapped to MITRE ATT&CK, a TheHive/Cortex/MISP/Shuffle SOAR stack, Zeek/Suricata
network monitoring, structured threat hunting, and NIST-aligned incident response
playbooks — validated end-to-end with a documented purple-team exercise.

This is a portfolio project built in 10 phases. Each phase is documented under `docs/phase-notes/`.

## Overview

| Area | What's implemented |
|---|---|
| Infrastructure | Proxmox VE host, pfSense firewall/router, VLAN-segmented network |
| SIEM | Wazuh (manager + indexer + dashboard, single-node) |
| Network monitoring | Zeek + Suricata on a mirrored interface |
| Detection engineering | Sigma rules → Wazuh rules, MITRE ATT&CK mapped |
| Threat hunting | Documented hunt log, Lucene + KQL-equivalent queries |
| SOAR | TheHive + Cortex + MISP + Shuffle, Docker Compose stack |
| Incident response | NIST 800-61 aligned playbooks, Velociraptor forensics |
| Validation | Full purple-team exercise with measured MTTD/MTTC |

## Architecture

See `docs/architecture/logical-architecture.md` and `docs/architecture/ip-plan.md`.

Four VLANs enforce real separation of concerns:
- **VLAN 10** — Management/OOB
- **VLAN 20** — SOC Tooling (Wazuh, TheHive/Cortex/MISP/Shuffle)
- **VLAN 30** — Monitored/Production (AD, Windows 11, Ubuntu endpoint)
- **VLAN 40** — Attacker (isolated; one-way to VLAN 30 only)

## Key Engineering Decisions

- **Resource-constrained design (8GB host)**: rather than running every listed tool
  simultaneously, the lab uses an operating-mode rotation model (`docs/phase-notes/`
  Phase 2) — a small always-on core (pfSense, Wazuh, Ubuntu endpoint) plus rotating
  Mode A (AD + Windows detection), Mode B (network/attacker), and Mode C (SOAR) groups.
- **VLAN segmentation enforced at pfSense**, verified via logged deny rules —
  the attacker VLAN cannot reach SOC tooling or management, only the monitored segment.
- **Detection-as-code pipeline**: Sigma is the source of truth, converted to Wazuh's
  native rule format, with a living MITRE ATT&CK coverage matrix.
- **Single log-shipping mechanism** (Wazuh agent everywhere) rather than mixing
  Beats and syslog, for a cleaner, more defensible architecture.

## Highlights

- [`detections/mitre-mapping/coverage-matrix.md`](detections/mitre-mapping/coverage-matrix.md) — MITRE ATT&CK coverage
- [`incident-response/exercises/purple-team-01-full-chain.md`](incident-response/exercises/purple-team-01-full-chain.md) — full attack chain, MTTD/MTTC measured
- [`detections/sigma/`](detections/sigma/) — Sigma detection rules
- [`threat-hunting/hunt-log.md`](threat-hunting/hunt-log.md) — structured hunt log

## Tech Stack

Proxmox VE · pfSense · Wazuh · Zeek · Suricata · TheHive · Cortex · MISP · Shuffle ·
Velociraptor · Sysmon · osquery · Docker · Ansible · GitHub Actions

## Repository Structure

```
soc-home-lab/
├── docs/                    Architecture, phase notes, runbooks, interview prep
├── infrastructure/          Proxmox, pfSense, Ansible
├── docker/                  Compose files for Wazuh, SOC tools, monitoring
├── detections/              Sigma, YARA, Wazuh rules, MITRE mapping
├── agents/                  Sysmon config, Winlogbeat/Filebeat/Auditd notes
├── simulations/             Attack scenarios, purple-team exercises
├── soar/                    Shuffle playbooks
├── scripts/                 Bash/Python/PowerShell automation
├── threat-hunting/          Hunt log and queries (Lucene + KQL-equivalent)
├── incident-response/       IR playbooks, forensics, exercises
└── .github/workflows/       CI: Sigma/YARA rule validation
```

## Setup

Full phase-by-phase build guide: see `docs/phase-notes/phase1-architecture.md`
through `phase10-portfolio.md`. Build order:

1. Architecture & IP plan
2. Proxmox + pfSense + VLANs
3. VM deployment (Ubuntu, Windows Server AD, Windows 11, Kali)
4. Networking (NTP, DNS, traffic mirroring)
5. Logging (Wazuh, Sysmon, Zeek/Suricata)
6. Detection engineering (Sigma/Wazuh/YARA)
7. Threat hunting
8. SOAR (TheHive/Cortex/MISP/Shuffle)
9. Incident response & purple team
10. Portfolio packaging

## License

MIT — see LICENSE.
