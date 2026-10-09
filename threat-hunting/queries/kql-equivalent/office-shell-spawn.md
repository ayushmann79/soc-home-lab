# Hunt #003 — KQL Equivalent

```kql
DeviceProcessEvents
| where InitiatingProcessFileName in ("winword.exe", "excel.exe", "outlook.exe")
| where FileName in ("cmd.exe", "powershell.exe")
```
