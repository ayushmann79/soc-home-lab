# Attack Simulation Scripts

Safe, lab-only test scripts used to validate detections end-to-end. Each
script corresponds to a specific Sigma/Wazuh rule and is meant to be run
against the lab's own monitored endpoints (Mode A/B) — never against a
system outside this lab.

| Script | Validates | Rule |
|---|---|---|
| encoded-powershell-test.ps1 | Encoded PowerShell detection | Sigma-0001 / Wazuh-100011 |
| sudo-shell-spawn-test.sh | Sudo privilege escalation detection | Sigma-0005 / Wazuh-100014 |

Additional scenario scripts (scheduled task creation, LSASS access via a
benign test harness, DNS tunneling simulation, etc.) follow the same
pattern — add one per implemented Sigma rule as the detection set grows.
See `docs/phase-notes/phase6-detection-engineering.md` for the validation
workflow and `incident-response/exercises/purple-team-01-full-chain.md` for
the full chained exercise these scripts feed into.
