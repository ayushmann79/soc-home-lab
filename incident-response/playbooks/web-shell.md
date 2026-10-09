# IR Playbook: Web Shell

Aligned to NIST SP 800-61.

## Preparation
- Detection: unexpected file creation in web server directories, unusual
  child processes spawned by the web server process (w3wp.exe, apache2,
  nginx), Suricata web-shell signature hits

## Detection & Analysis
1. Preserve web server logs before any remediation - these are critical
   forensic evidence and are often the first thing lost during cleanup
2. Identify the dropped file, its creation timestamp, and how it arrived
   (upload form, RCE vulnerability, credential compromise)
3. Check for outbound connections initiated by the web server process
   (possible C2 or data staging)

## Containment
1. Take the affected web application offline or isolate it at the network
   level while preserving evidence
2. Block the web shell's known C2/callback IP at pfSense if identified

## Eradication
1. Remove the web shell file and any associated backdoor accounts
2. Patch the vulnerability that allowed the upload/RCE
3. Velociraptor hunt for the same file hash across other web-facing hosts

## Recovery
1. Restore the application from a known-good backup/deployment pipeline
   rather than trusting in-place cleanup
2. Re-enable access only after confirming the vulnerability is patched

## Lessons Learned
- Document the vulnerability class (e.g., unrestricted file upload) and
  feed back into secure coding/hardening guidance
