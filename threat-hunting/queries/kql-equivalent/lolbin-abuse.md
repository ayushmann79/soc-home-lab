# Hunt #002 — KQL Equivalent

```kql
DeviceProcessEvents
| where FileName in ("certutil.exe", "mshta.exe", "rundll32.exe")
| where ProcessCommandLine has_any ("http", "urlcache", "javascript:")
```
