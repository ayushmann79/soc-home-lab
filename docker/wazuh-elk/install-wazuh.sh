#!/bin/bash
# Single-node Wazuh install (manager + indexer + dashboard, all-in-one)
set -euo pipefail

curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh
bash wazuh-install.sh -a

echo "Save the generated admin credentials to a gitignored local secrets file."
echo "Do NOT commit them. Tune indexer heap next: /etc/wazuh-indexer/jvm.options"
