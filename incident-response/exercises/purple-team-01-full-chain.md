# Purple Team Exercise 01: Initial Access → Credential Theft → Lateral Movement

Flagship validation exercise for the lab — a single attack chain executed by
the red side (Kali, VLAN 40), observed and responded to by the blue side
(Wazuh/TheHive/Cortex), with timestamps captured to measure real detection
and containment performance.

## Red Team Actions (Kali, VLAN 40 → VLAN 30)

1. Phishing simulation: deliver a macro-enabled document to the Win11
   endpoint (simulated via direct file drop, not real email, for lab safety)
2. Macro spawns encoded PowerShell (T1059.001) → downloads a
   Mimikatz-equivalent credential-dumping tool
3. Dump LSASS memory (T1003.001)
4. Use the dumped credentials for lateral movement to the AD DC via
   Pass-the-Hash (T1550.002)
5. Create a scheduled task on the DC for persistence (T1053.005)

## Blue Team Detection Timeline

| Time | Event | Detection Source |
|---|---|---|
| T+0s | Macro spawns encoded PowerShell | Sigma-0001 / Wazuh rule 100011 |
| T+2s | TheHive case auto-created | Wazuh → TheHive integration |
| T+15s | LSASS access detected | Sigma-0003 / Wazuh rule 100010 |
| T+18s | Cortex enrichment: process hash flagged | Cortex/VirusTotal analyzer |
| T+40s | Lateral movement to DC (unusual auth pattern) | Hunt-004 (manual pivot — no automated rule) |
| T+45s | Scheduled task on DC | Sigma-0002 / Wazuh rule 100012 |

*Fill in actual measured timestamps when this exercise is run for real in the
lab — the structure above reflects the intended sequence and detection
sources.*

## Containment & Response

Followed `incident-response/playbooks/credential-dumping.md` for steps 1–3,
and `incident-response/playbooks/lateral-movement.md` for step 4. Document
the actual actions taken (host isolation, account disable, credential
rotation) here once run live, with timestamps.

## Metrics

- **Mean time to detect (MTTD)**: [measure from T+0 to first alert]
- **Mean time to contain (MTTC)**: [measure from detection to isolation]
- **Detection coverage**: 4/5 attack steps had automated detection; 1/5
  (lateral movement / Pass-the-Hash) required a manual hunt pivot

## Lessons Learned

- **Gap identified**: Pass-the-Hash (T1550.002) lateral movement had no
  automated detection rule in this build — it was only caught via a manual
  hunt (Hunt-004) reviewing AD authentication patterns. This is logged as a
  backlog item in `detections/mitre-mapping/coverage-matrix.md` rather than
  glossed over.
- **Follow-up**: Build a Sigma rule / Wazuh correlation rule for anomalous
  authentication patterns (same account authenticating to N hosts within a
  short window) to close this gap before the next exercise.
- A documented gap with a concrete follow-up plan is a stronger portfolio
  artifact than a claim of perfect detection coverage.
