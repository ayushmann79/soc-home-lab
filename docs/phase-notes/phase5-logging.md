# Phase 5: Logging

## Objectives
Stand up Wazuh (manager+indexer+dashboard, single-node) as the SIEM spine,
deploy the Zeek/Suricata sensor with the Phase 4 mirror wired in, roll out
Sysmon on Windows, and get every host shipping logs through a single
mechanism: the Wazuh agent.

## Design decision: single shipping mechanism
Rather than running Filebeat AND Wazuh agents on the same boxes, Wazuh's
native modules for auditd and JSON log ingestion (Suricata eve.json, Zeek
conn.log/dns.log/http.log) are used directly — one agent, one pipeline,
easier to defend architecturally than mixing two shipping tools.

## Wazuh deployment
- VM 120, 10.10.20.10, 2.5GB RAM, single-node all-in-one installer
- Indexer heap tuned down: `-Xms1g -Xmx1g` in `/etc/wazuh-indexer/jvm.options`
- Dashboard reachable at https://10.10.20.10, VLAN 10 only (pfSense rule)

## Zeek + Suricata sensor (VM 150)
- Second NIC bridged untagged to vmbr0 for the mirror target
- Zeek: `/opt/zeek/etc/node.cfg` interface set to the mirror NIC
- Suricata: af-packet on the mirror NIC, Emerging Threats Open ruleset via `suricata-update`
- Both log formats ingested by Wazuh via `<localfile>` JSON blocks in `ossec.conf`

## Sysmon (Windows, Mode A)
Base config: SwiftOnSecurity's public Sysmon config, extended with lab-specific
tuning — see `agents/sysmon/sysmon-config.xml` and the attribution note in that file.

## Verification
- Wazuh Dashboard shows Ubuntu endpoint and sensor VM as active agents
- Zeek conn.log entries visible in Wazuh Discover within seconds of test traffic
- Suricata test-rule alert appears in Wazuh
- Sysmon Event ID 1 from Win11 visible in Wazuh within seconds (Mode A)
