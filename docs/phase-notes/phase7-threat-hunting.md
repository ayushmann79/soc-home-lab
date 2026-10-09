# Phase 7: Threat Hunting

## Objectives
Move from alert-driven to hypothesis-driven hunting. Build the beaconing
detection deferred from Phase 6, plus a set of hunts documented the way a
real threat-hunt program tracks them: hypothesis, data source, query,
findings, disposition.

## Hunts documented (see threat-hunting/hunt-log.md)
| # | Hunt | Technique | Status |
|---|---|---|---|
| 001 | Beaconing to external IPs | T1071.001 | Closes Phase 6 gap |
| 002 | LOLBin abuse (certutil/mshta/rundll32) | T1218 | Implemented |
| 003 | Office app spawning shell | T1204.002 | Implemented |
| 004 | New local admin account | T1136.001 | Implemented |
| 005 | Cron spawning outbound curl | T1053.003 | Implemented |
| 006 | Suricata alert clustering by source host | — | Visualization target |

## Design note
Every hunt is documented in both Wazuh/Lucene syntax (what the lab actually
runs) and KQL-equivalent syntax (what most job postings ask for), so the
underlying detection logic is shown to transfer across SIEM platforms rather
than being tool-specific memorization.

## Verification
- Hunt-001 and Hunt-002 run against real Mode A/B generated activity
- Results captured in hunt-log.md with disposition marked
- MITRE coverage matrix updated: T1071.001 moves from "Planned" to "Implemented"
