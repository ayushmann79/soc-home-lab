# Threat Hunt Log

Structured, hypothesis-driven hunts against the lab's live log data.
Template used for every hunt:

```
## Hunt #NNN — Title
Hypothesis:
Data source:
ATT&CK mapping:
Query: (see threat-hunting/queries/)
Findings:
Disposition: True positive / False positive / Inconclusive
Follow-up:
```

---

## Hunt #001 — Beaconing to External IPs
**Hypothesis**: An implant on a monitored host is beaconing to a C2 server at
regular, low-jitter intervals.
**Data source**: Zeek conn.log via Wazuh indexer
**ATT&CK mapping**: T1071.001
**Query**: `threat-hunting/queries/lucene/beaconing-agg.md`
**Findings**: [fill in after running against real Mode B traffic]
**Disposition**: Pending live run
**Follow-up**: Once validated, promote to a Wazuh correlation rule (closes the
gap deferred from Phase 6)

## Hunt #002 — LOLBin Abuse
**Hypothesis**: An attacker is using signed native Windows binaries
(certutil, mshta, rundll32) to download or execute payloads, evading
binary-based detection.
**Data source**: Sysmon Event ID 1 via Wazuh
**ATT&CK mapping**: T1218
**Query**: `threat-hunting/queries/lucene/lolbin-abuse.md`
**Findings**: [fill in after running against Mode A traffic]
**Disposition**: Pending live run
**Follow-up**: —

## Hunt #003 — Office Application Spawning a Shell
**Hypothesis**: Office applications or browsers spawning command interpreters
indicates exploitation (macro payload, phishing).
**Data source**: Sysmon Event ID 1 (parent-child relationship) via Wazuh
**ATT&CK mapping**: T1204.002
**Query**: `threat-hunting/queries/lucene/office-shell-spawn.md`
**Findings**: [fill in]
**Disposition**: Pending live run
**Follow-up**: —

## Hunt #004 — New Local Admin Account Creation
**Hypothesis**: Privilege escalation or persistence via unauthorized addition
to the local Administrators group.
**Data source**: Windows Security event log (Event ID 4732) via Wazuh
**ATT&CK mapping**: T1136.001
**Query**: `threat-hunting/queries/lucene/new-local-admin.md`
**Findings**: [fill in]
**Disposition**: Pending live run
**Follow-up**: Cross-reference against the AD user baseline documented in
`docs/phase-notes/phase3-vm-deployment.md`

## Hunt #005 — Cron Spawning Outbound curl
**Hypothesis**: A cron-based persistence mechanism is exfiltrating data or
phoning home.
**Data source**: auditd (EXECVE) via Wazuh
**ATT&CK mapping**: T1053.003
**Query**: `threat-hunting/queries/lucene/cron-curl.md`
**Findings**: [fill in]
**Disposition**: Pending live run
**Follow-up**: —

## Hunt #006 — Suricata Alert Clustering by Source Host
**Hypothesis**: One host generating a disproportionate share of Suricata
alerts indicates active compromise rather than background noise.
**Data source**: Suricata eve.json via Wazuh
**ATT&CK mapping**: — (triage aid, not technique-specific)
**Query**: `threat-hunting/queries/lucene/suricata-clustering.md` (visualization target,
not a single Discover query — see notes in that file)
**Findings**: [fill in]
**Disposition**: Pending live run
**Follow-up**: —
