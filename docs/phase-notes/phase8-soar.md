# Phase 8: SOAR

## Objectives
Deploy TheHive + Cortex + MISP + Shuffle as one consolidated Docker Compose
stack (Mode C, VLAN 20, VM 121), wire Wazuh alerts into TheHive as cases,
use Cortex for automated IOC enrichment, and build one working end-to-end
Shuffle playbook.

## Resource note
Given the 3GB budget for VM 121, TheHive + Cortex + their shared Elasticsearch
run persistently during Mode C sessions; MISP and Shuffle are brought up
individually when actively building/testing rather than assuming all six
containers run simultaneously. `docker stats` output captured as evidence
in this file once real usage is measured.

## Integration chain
Wazuh alert (rule 100010, LSASS access) -> `custom-w2thive.py` integration ->
auto-created TheHive case -> Cortex analyzer run against observable (VirusTotal/
AbuseIPDB/MISP lookup) -> Shuffle playbook triggered on case creation ->
tag case + notify.

## Playbook: "Enrich and Notify on Wazuh Critical Alert"
1. Trigger: webhook on TheHive case creation
2. Extract observable (source IP) from case
3. Call Cortex's AbuseIPDB analyzer
4. If reputation score exceeds threshold, tag case `confirmed-malicious`
5. Send notification

See `soar/shuffle-playbooks/enrich-and-notify.json`.

## Verification
- TheHive/Cortex reachable at 10.10.20.11:9000/:9001 from VLAN 10 only
- Re-running the Phase 6 encoded-PowerShell test produces an auto-created
  TheHive case within seconds
- At least one Cortex analyzer run against a real observable, results visible
- Shuffle playbook executes end-to-end at least once
