# MITRE ATT&CK Coverage Matrix

Living document tracking which techniques this lab can detect, and how.
Update whenever a new Sigma/Wazuh rule or hunting query is implemented and tested.

| Tactic | Technique | Rule/Hunt ID | Source | Status |
|---|---|---|---|---|
| Execution | T1059.001 (PowerShell) | Sigma-0001 / Wazuh-100011 | Sysmon | Implemented |
| Defense Evasion | T1027 (Obfuscation) | Sigma-0001 / Wazuh-100011 | Sysmon | Implemented |
| Persistence | T1053.005 (Scheduled Task) | Sigma-0002 / Wazuh-100012 | Sysmon | Implemented |
| Credential Access | T1003.001 (LSASS Memory) | Sigma-0003 / Wazuh-100010 | Sysmon | Implemented |
| Persistence | T1543.003 (Windows Service) | Sigma-0004 / Wazuh-100013 | Sysmon | Implemented |
| Privilege Escalation | T1548.003 (Sudo) | Sigma-0005 / Wazuh-100014 | auditd | Implemented |
| Command and Control | T1059.004 (Bash Reverse Shell) | Sigma-0006 / Wazuh-100015 | auditd | Implemented |
| Command and Control | T1071.004 (DNS Tunneling) | Sigma-0007 / Wazuh-100016 | Zeek | Implemented |
| Command and Control | T1071.001 (Beaconing) | Hunt-001 | Zeek conn.log | Implemented (via hunting query) |
| Defense Evasion | T1218 (LOLBins) | Hunt-002 | Sysmon | Implemented (via hunting query) |
| Execution | T1204.002 (Malicious File - Office) | Hunt-003 | Sysmon | Implemented (via hunting query) |
| Persistence | T1136.001 (Local Account) | Hunt-004 | Security event log | Implemented (via hunting query) |
| Persistence | T1053.003 (Cron) | Hunt-005 | auditd | Implemented (via hunting query) |
| Lateral Movement | T1550.002 (Pass the Hash) | — | — | **Gap** — identified in Purple Team Exercise 01, no automated detection yet, backlog item |

## Notes
- "Implemented" here means: rule/query written, syntax-validated, and fired
  successfully against a real generated technique in the lab (not just written).
- The lateral-movement gap is intentionally left visible rather than hidden —
  see `incident-response/exercises/purple-team-01-full-chain.md` for the
  finding and follow-up plan.
- A MITRE Navigator-compatible JSON layer can be generated from this table
  for a visual heatmap (`mitre-mapping/navigator-layer.json` placeholder —
  populate via the ATT&CK Navigator "create layer" import feature).
