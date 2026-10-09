# Phase 9: Incident Response

## Objectives
Formal NIST 800-61 aligned IR playbooks, Velociraptor for live forensic triage,
and a full purple-team exercise walking one attack chain end-to-end.

## Playbooks (incident-response/playbooks/)
- credential-dumping.md
- ransomware.md
- web-shell.md
- lateral-movement.md

Each follows: Preparation -> Detection & Analysis -> Containment -> Eradication
-> Recovery -> Lessons Learned.

## Velociraptor
Deployed as VM 160 (~400MB, VLAN 20), clients pushed to Windows/Ubuntu
endpoints. Used for hunts across the fleet (e.g., searching for the LOLBin
pattern from Hunt-002) — distinct from Wazuh's real-time alerting, this is
the live forensic triage capability.

## Purple Team Exercise 01
Full chain: phishing simulation (file drop, not real email, for lab safety) ->
encoded PowerShell -> LSASS dump -> pass-the-hash lateral movement to AD DC ->
scheduled task persistence. Documented with an actual detection timeline and
MTTD/MTTC measurements in `incident-response/exercises/purple-team-01-full-chain.md`.

Honest finding: lateral movement (pass-the-hash) had no automated detection
in this build and required a manual hunt pivot — logged as a backlog item
rather than glossed over, since a documented gap is more credible than a
claim of perfect coverage.

## Verification
- Playbook followed and results (containment/eradication actions, timestamps)
  recorded in the associated TheHive case
- Purple Team Exercise 01 run for real with measured timestamps
