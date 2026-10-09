# IR Playbook: Ransomware

Aligned to NIST SP 800-61.

## Preparation
- Detection: mass file modification/encryption pattern (FIM alerts), unusual
  process spawning encryption-related file extensions, Suricata/Zeek C2
  indicators
- Tools: Wazuh FIM, Velociraptor, offline backups (verify integrity regularly)

## Detection & Analysis
1. Confirm scope: which hosts show encryption activity, timestamp of first event
2. Identify the ransomware family if possible (ransom note contents, file
   extension pattern) via OSINT/MISP lookup - do not pay, do not negotiate
3. Determine initial access vector (phishing? exposed RDP? credential reuse?)

## Containment
1. Immediately isolate affected hosts from the network (VLAN 30) - do this
   fast, before full analysis, given the propagation risk
2. Disable shared network drives/mounts temporarily to limit lateral spread
3. Preserve one affected system in current state for forensics before wiping

## Eradication
1. Identify and remove the persistence/initial-access foothold across the
   environment via Velociraptor hunt
2. Confirm no backdoor remains before restoring any host

## Recovery
1. Restore from verified clean backups (never restore encrypted data hoping
   it decrypts)
2. Rebuild affected hosts from known-good images rather than trusting
   in-place cleanup
3. Monitor closely post-recovery for reinfection indicators

## Lessons Learned
- Document initial access vector and update detection/hardening accordingly
- Review backup integrity/frequency if recovery was incomplete or slow
