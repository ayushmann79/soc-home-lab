# Sysmon Configuration

Base config: SwiftOnSecurity's public Sysmon configuration
(https://github.com/SwiftOnSecurity/sysmon-config), used as the starting
point and extended with lab-specific tuning for this project. Not copied
silently — cited here as the base being extended, per standard attribution
practice for community security configs.

`sysmon-config.xml` in this directory is the lab's working config. Track
lab-specific deltas from upstream in comments within the file, or as a
changelog entry here, so it's clear what was added versus inherited.

## Install
```powershell
.\Sysmon64.exe -accepteula -i sysmon-config.xml
```
