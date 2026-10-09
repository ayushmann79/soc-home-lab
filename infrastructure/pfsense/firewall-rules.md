# pfSense Firewall Rules

## Interface OPT3 (ATTACKER, VLAN 40)
| # | Action | Source | Destination | Port | Log |
|---|---|---|---|---|---|
| 1 | Allow | VLAN 40 | VLAN 30 | any | No |
| 2 | Deny | VLAN 40 | VLAN 20 | any | Yes |
| 3 | Deny | VLAN 40 | VLAN 10 | any | Yes |
| 4 | Allow | VLAN 40 | WAN | any | No |

## Interface OPT1 (SOC_TOOLING, VLAN 20)
| # | Action | Source | Destination | Port | Log |
|---|---|---|---|---|---|
| 1 | Allow | VLAN 30 | 10.10.20.10 | 1514,1515 tcp/udp | No |
| 2 | Allow | VLAN 10 | 10.10.20.10 | 443 | No |
| 3 | Allow | VLAN 10 | 10.10.20.11 | 9000,9001 | No |
| 4 | Deny | any | VLAN 20 | any | Yes |

## Interface OPT2 (MONITORED, VLAN 30)
| # | Action | Source | Destination | Port | Log |
|---|---|---|---|---|---|
| 1 | Allow | VLAN 10 | VLAN 30 | any | No |
| 2 | Allow | VLAN 40 | VLAN 30 | any | No |
| 3 | Allow | VLAN 30 | VLAN 20 | any | No |

## Verification commands (run from a test box on VLAN 40)
```bash
ping 10.10.30.x   # should succeed
ping 10.10.20.x   # should FAIL - check pfSense Status > System Logs > Firewall for the deny entry
ping 10.10.10.x   # should FAIL
```
