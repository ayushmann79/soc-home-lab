# Hunt #001 — Beaconing Detection

## Base query (Wazuh Discover, Lucene syntax)
```
data.zeek.conn.id.resp_h:* AND NOT data.zeek.conn.id.resp_h:(10.10.0.0/16)
```

## Aggregation approach
Beaconing shows up as many short connections to the same external IP at
regular, low-jitter intervals - this needs a visualization, not a single
query. Build a Wazuh/Kibana visualization:
- Bucket by `data.zeek.conn.id.resp_h` and `data.zeek.conn.id.orig_h`
- Count connections over fixed time intervals (e.g. 5-minute buckets)
- A host with near-identical connection counts every N minutes to the same
  destination is the beaconing candidate

Once validated against real traffic (Kali running a scripted periodic
callback in Mode B), promote this to a proper Wazuh correlation rule.
