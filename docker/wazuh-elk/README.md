# Wazuh SIEM (VM 120, 10.10.20.10)

Single-node all-in-one install (manager + indexer + dashboard co-located).
This is the correct call at this RAM tier rather than splitting into three
VMs or running a separate full Elastic Stack alongside it.

## Install
See `install-wazuh.sh`. After install, apply `jvm.options.override` to
`/etc/wazuh-indexer/jvm.options` and restart:
```bash
systemctl restart wazuh-indexer wazuh-manager wazuh-dashboard
```

## Custom detection rules
Placed at `/var/ossec/etc/rules/local_rules.xml` on the manager - source of
truth for these lives in `detections/wazuh-rules/local_rules.xml` in this repo.

## TheHive integration
See `docker/soc-tools/wazuh-thehive-integration.md`.
