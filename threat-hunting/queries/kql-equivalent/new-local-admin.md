# Hunt #004 — KQL Equivalent

```kql
SecurityEvent
| where EventID == 4732
| where TargetGroupName == "Administrators"
```
