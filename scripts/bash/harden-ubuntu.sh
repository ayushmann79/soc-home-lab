#!/bin/bash
# Baseline hardening for the always-on Ubuntu endpoint
set -euo pipefail

apt update && apt upgrade -y
apt install -y auditd audispd-plugins ufw fail2ban curl

systemctl enable --now auditd

ufw default deny incoming
ufw default allow outgoing
ufw allow from 10.10.10.0/24 to any port 22
ufw --force enable

systemctl enable --now fail2ban
