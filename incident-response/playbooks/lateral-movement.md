# IR Playbook: Lateral Movement

Aligned to NIST SP 800-61.

## Preparation
- Detection: unusual authentication patterns (same credential, multiple
  hosts, short time window), Pass-the-Hash indicators, new admin sessions
  from unexpected source hosts
- Known gap: this lab currently lacks an automated Sigma/Wazuh rule for
  Pass-the-Hash (T1550.002) - see the finding in
  incident-response/exercises/purple-team-01-full-chain.md. Detection today
  relies on manual hunting (Hunt-004 and AD authentication log review).

## Detection & Analysis
1. Review AD authentication logs for the affected account across all hosts
   in the suspected time window
2. Correlate with the originating host's credential-dumping alert (if any)
   to establish the source of the stolen credential
3. Map the full path of movement: source host -> target host -> target host

## Containment
1. Isolate all hosts in the identified movement path
2. Disable the compromised account(s) immediately
3. Force a password reset / Kerberos ticket invalidation (krbtgt reset if
   Golden Ticket is suspected)

## Eradication
1. Velociraptor hunt across the environment for the same technique/tooling
2. Remove any persistence established on newly-reached hosts

## Recovery
1. Re-enable accounts and hosts only after confirming clean state
2. Monitor authentication logs closely for repeat attempts

## Lessons Learned
- This playbook exists partly to formalize response to a technique the
  lab cannot yet detect automatically - the backlog item is to build a
  Sigma rule/Wazuh correlation for anomalous authentication patterns
  (e.g., same account authenticating to N hosts within M minutes)
