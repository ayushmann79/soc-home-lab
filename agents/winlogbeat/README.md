# Windows log shipping

Standard Wazuh agent Windows install ships Sysmon and Security event log
channels natively. Add to `ossec.conf` on each Windows agent:

```xml
<localfile>
  <location>Microsoft-Windows-Sysmon/Operational</location>
  <log_format>eventchannel</log_format>
</localfile>
<localfile>
  <location>Security</location>
  <log_format>eventchannel</log_format>
</localfile>
```

Deployment: see `scripts/powershell/deploy-sysmon-wazuh-agent.ps1`.
