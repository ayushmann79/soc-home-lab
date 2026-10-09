# IR Playbook: Credential Dumping (LSASS Access)

Aligned to NIST SP 800-61.

## Preparation
- Detection: Wazuh rule 100010 (T1003.001) auto-opens a TheHive case
- Runbook owner: SOC analyst on duty
- Tools: Wazuh, TheHive, Velociraptor, AD DC access

## Detection & Analysis
1. Confirm true positive: check GrantedAccess mask, parent process, and user
   context in Wazuh
2. Pivot to the TheHive case, review auto-enriched observables (source host,
   process, user)
3. Check Hunt-003 (parent-child anomalies) for related activity on the same
   host in the prior 24h

## Containment
1. Isolate the affected host: quarantine via Wazuh active-response (disable
   network) or manually pull the VM from VLAN 30 in Proxmox
2. Disable the compromised user account in AD if credential theft is confirmed
3. Rotate any credentials confirmed or suspected dumped

## Eradication
1. Velociraptor hunt across VLAN 30 hosts for the same process hash / LOLBin
   pattern
2. Remove persistence mechanisms found (scheduled tasks, services) per
   Hunt-002/Hunt-004 findings

## Recovery
1. Re-image or restore the affected endpoint from a known-good snapshot
2. Re-enable network access, monitor closely for 48h (heightened Wazuh
   alert threshold)

## Lessons Learned
- Document in the TheHive case: detection latency, containment time, gaps found
- Update the Sigma/Wazuh rule if an evasion technique bypassed initial detection
