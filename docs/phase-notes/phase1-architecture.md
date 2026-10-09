# Phase 1: Architecture

## Objectives
- Define logical architecture and network segmentation
- Lock in IP addressing scheme
- Size VMs against 8-16GB RAM constraint
- Define repo structure

## Hardware reality check
8-16GB RAM total running Proxmox as host is not enough to run all 20+ originally
listed components simultaneously as full VMs. Decisions made to fit reality:
- Wazuh chosen as primary SIEM instead of running both Security Onion AND a
  separate Elastic Stack (redundant — Wazuh ships its own OpenSearch-based indexer)
- TheHive + Cortex + MISP + Shuffle consolidated onto one Docker Compose VM
  instead of 4 separate VMs
- Attacker and Windows endpoints powered on only during exercises, not left
  running 24/7

See `docs/architecture/logical-architecture.md` and `docs/architecture/ip-plan.md`
for the resulting design.

## Deliverables produced this phase
- Logical architecture diagram (4-VLAN model)
- IP addressing table
- Repository folder structure
