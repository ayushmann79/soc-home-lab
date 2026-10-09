# Phase 6: Detection Engineering

## Objectives
Build a detection-as-code pipeline: Sigma rules (source of truth, vendor-neutral)
converted to Wazuh's native rule format, mapped to MITRE ATT&CK, plus a starter
YARA ruleset. Quality and traceability over raw rule count.

## Pipeline
Sigma (`detections/sigma/`) -> converted/ported -> Wazuh custom rules
(`detections/wazuh-rules/local_rules.xml`) -> validated with `wazuh-logtest`
before deployment -> MITRE coverage tracked in
`detections/mitre-mapping/coverage-matrix.md`.

## Rules implemented this phase
| ID | Title | Technique | Source |
|---|---|---|---|
| Sigma-0001 | Suspicious Encoded PowerShell | T1059.001, T1027 | Sysmon |
| Sigma-0002 | Scheduled Task via schtasks.exe | T1053.005 | Sysmon |
| Sigma-0003 | LSASS Access (credential dumping) | T1003.001 | Sysmon |
| Sigma-0004 | New Windows Service Created | T1543.003 | Sysmon |
| Sigma-0005 | Sudo Privilege Escalation via Shell | T1548.003 | auditd |
| Sigma-0006 | Bash Reverse Shell via /dev/tcp | T1059.004 | auditd |
| Sigma-0007 | Possible DNS Tunneling | T1071.004 | Zeek |

Beaconing (T1071.001) intentionally deferred to Phase 7 — it requires
aggregation over time and doesn't fit a single-event Sigma rule honestly.

## Validation workflow
```bash
/var/ossec/bin/wazuh-logtest
```
All custom rules validated for syntax before deployment; CI also lints Sigma
YAML and YARA syntax on every push (`.github/workflows/validate-rules.yml`).

## Verification
- Encoded PowerShell test (`powershell.exe -enc ...`) produces a Wazuh alert
  within seconds; latency measured and logged
- Sudo shell-spawn test on Ubuntu produces a corresponding auditd-based alert
- MITRE coverage matrix reflects only rules actually implemented and tested
