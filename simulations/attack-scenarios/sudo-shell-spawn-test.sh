#!/bin/bash
# Test script for Sigma-0005 / Wazuh rule 100014 (sudo shell spawn detection)
# Run on the Ubuntu endpoint to validate the auditd-based detection pipeline.
set -euo pipefail

sudo bash -c 'echo "detection test"'

echo "Test executed. Confirm a Wazuh alert (rule 100014) appears within seconds."
