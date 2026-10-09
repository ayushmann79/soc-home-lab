# Phase 3: VM Deployment

## Objectives
Build the endpoint VMs: Ubuntu (always-on core), Windows Server AD DC + Windows 11
(Mode A), Kali (Mode B). All are created up front; only Ubuntu runs persistently.

## VMs created
| VMID | Name | vCPU | RAM | VLAN | Boot on host start |
|---|---|---|---|---|---|
| 130 | ubuntu-endpoint | 1 | 512MB | 30 | Yes |
| 131 | win-server-adds | 2 | 2GB | 30 | No (Mode A) |
| 132 | win11-endpoint | 2 | 2GB | 30 | No (Mode A) |
| 140 | kali-attacker | 2 | 1.5GB | 40 | No (Mode B) |

See `scripts/bash/vm-create-*.sh` for the exact `qm create` commands and
`scripts/powershell/deploy-adds.ps1` for the AD Domain Services install.

## Notes
- Windows 11 requires UEFI + TPM 2.0 (`--bios ovmf`, `--efidisk0`, `--tpmstate0`)
- AD domain: `soclab.local`, NetBIOS `SOCLAB`
- Rotation VMs set with `qm set <id> --onboot 0` so they never auto-start —
  Mode switching is deliberate, via `scripts/bash/mode-a.sh` / `mode-b.sh`

## Verification
- `qm list` shows all 4 VMs, with 131/132/140 set to onboot:0
- Ubuntu endpoint pings pfSense gateway and resolves DNS
- Idle `free -h` (pfSense + Ubuntu only) shows comfortable headroom
