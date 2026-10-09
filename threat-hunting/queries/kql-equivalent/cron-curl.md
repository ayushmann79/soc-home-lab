# Hunt #005 — KQL Equivalent

```kql
DeviceProcessEvents
| where FileName == "curl"
| where InitiatingProcessFileName == "cron"
```
