# Hunt #006 — Suricata Alert Clustering by Source Host

Wazuh Discover doesn't support stats/sort pipe syntax natively. This is a
target for a Kibana/OpenSearch Dashboards visualization instead - a terms
aggregation on `src_ip` from Suricata's eve.json alerts, sorted descending
by count. Note the translation explicitly here so it reads as an intentional
design choice, not an error:

Conceptual pipe (not runnable as-is in Wazuh Discover):
```
rule.groups:"suricata" | stats count by src_ip | sort count desc
```

Actual implementation: build as a Wazuh/OpenSearch Dashboards visualization
with a terms aggregation on `data.suricata.src_ip`.
