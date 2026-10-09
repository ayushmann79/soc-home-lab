# Hunt #001 — KQL Equivalent

```kql
DeviceNetworkEvents
| where RemoteIPType == "Public"
| summarize ConnectionCount = count() by RemoteIP, LocalIP, bin(Timestamp, 5m)
| summarize IntervalVariance = stdev(ConnectionCount) by RemoteIP, LocalIP
| where IntervalVariance < 1.0
```
Low variance in connection count across fixed time buckets to the same
remote IP is the beaconing signal - conceptually equivalent to the
Lucene/Kibana aggregation approach used in the lab's actual Wazuh stack.
