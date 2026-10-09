# Likely Interview Questions and How to Answer Using This Project

**"Walk me through your lab's architecture"**
Use the VLAN diagram (docs/architecture/logical-architecture.md). Explain
why attacker traffic (VLAN 40) can't reach SOC tooling (VLAN 20), and how
that's enforced and verified via pfSense logged deny rules.

**"Tell me about a detection you built"**
LSASS/T1003.001 rule — walk through the Sigma rule, the conversion to a
Wazuh rule, and the false-positive consideration (legitimate AV/security
tools also read LSASS memory).

**"Describe a time you found a gap in detection coverage"**
The lateral-movement (Pass-the-Hash) gap from Purple Team Exercise 01 — no
automated detection existed, it was caught via manual hunting, and it's
tracked as a backlog item with a concrete follow-up plan.

**"How do you handle resource or cost constraints?"**
The 8GB operating-mode rotation design (docs/phase-notes/phase2-infrastructure.md)
— always-on core plus rotating Mode A/B/C groups, with real `free -h`
evidence rather than just claimed numbers.
