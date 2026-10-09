# Deploys Sysmon and the Wazuh agent on a Windows endpoint (Win11 or AD DC)
# Run agents/sysmon/sysmon-config.xml must be present in the same directory,
# or update the path below.

# --- Sysmon ---
# Download Sysmon64.exe from Microsoft Sysinternals separately (not scripted
# here to avoid an unverified download in an automation script).
.\Sysmon64.exe -accepteula -i .\sysmon-config.xml

# --- Wazuh agent ---
$WazuhManager = "10.10.20.10"
Invoke-WebRequest -Uri "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.9.0-1.msi" -OutFile wazuh-agent.msi
msiexec.exe /i wazuh-agent.msi /q WAZUH_MANAGER="$WazuhManager" WAZUH_REGISTRATION_SERVER="$WazuhManager"
NET START WazuhSvc

Write-Host "Sysmon and Wazuh agent deployed. Confirm agent appears in Wazuh Dashboard under Agents."
