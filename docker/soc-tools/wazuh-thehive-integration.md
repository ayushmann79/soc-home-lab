# Wazuh -> TheHive Integration

Wazuh ships an official TheHive integration script.

## On the Wazuh manager
```bash
cp /var/ossec/integrations/custom-w2thive.py /var/ossec/integrations/
chmod 750 /var/ossec/integrations/custom-w2thive.py
chown root:wazuh /var/ossec/integrations/custom-w2thive.py
```

## In /var/ossec/etc/ossec.conf
```xml
<integration>
  <name>custom-w2thive</name>
  <hook_url>http://10.10.20.11:9000</hook_url>
  <api_key>YOUR_THEHIVE_API_KEY</api_key>
  <rule_id>100010,100011</rule_id>
  <alert_format>json</alert_format>
</integration>
```

Restart: `systemctl restart wazuh-manager`

A Wazuh alert matching rule 100010 (LSASS access) or 100011 (encoded
PowerShell) now automatically opens a case in TheHive. This alert-to-case
pipeline is the core of "SOAR" in this lab; enrichment (Cortex) and
notification (Shuffle) layer on top of it.
