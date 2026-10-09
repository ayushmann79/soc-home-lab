# Log shipping design note

Standalone Filebeat was considered for Zeek/Suricata/auditd log shipping, but
the lab standardizes on the **Wazuh agent everywhere** instead:

- Wazuh has native modules for auditd ingestion and JSON log ingestion
  (Suricata eve.json, Zeek conn.log/dns.log/http.log)
- Running two competing shipping agents (Filebeat + Wazuh agent) on the same
  box adds operational complexity without a real benefit at this lab's scale
- This is what a real deployment would standardize on for consistency

See `agents/auditd/wazuh-agent-ossec-conf-snippets.xml` for the actual
`<localfile>` configuration blocks used instead of Filebeat.
