# Phase 10: Portfolio

## Objectives
Package the project for public consumption: README, screenshots/GIFs list,
LinkedIn post ideas, resume bullets, interview prep, and CI for detection
rule validation.

## Screenshots/GIFs to capture (docs/interview-prep/screenshot-checklist.md)
- pfSense firewall log: blocked VLAN 40->20 attempt
- Wazuh dashboard: live agents + active alert
- TheHive case auto-created from Wazuh alert, with Cortex enrichment
- MITRE Navigator heatmap of coverage
- Shuffle playbook canvas
- Terminal GIF: encoded PowerShell -> alert in Wazuh within seconds

## CI
`.github/workflows/validate-rules.yml` lints Sigma YAML and YARA syntax on
every push/PR — a green badge signals detections are treated as code, not
one-off scripts.

## Materials produced
- docs/interview-prep/linkedin-posts.md
- docs/interview-prep/resume-bullets.md
- docs/interview-prep/interview-qa.md
- Root README.md (project overview, architecture, setup)
