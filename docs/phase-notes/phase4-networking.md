# Phase 4: Networking

## Objectives
NTP sync (critical for SIEM timestamp correlation), DNS design across VLANs,
and traffic mirroring so Zeek/Suricata can see VLAN 30 traffic on a
software-defined bridge with no physical SPAN port.

## Why NTP matters here
If Windows Server, Windows 11, Ubuntu, and Wazuh drift out of sync even by a
few seconds, timeline correlation in investigations becomes wrong — an alert
on the AD DC and its matching Sysmon event on Win11 won't line up in Wazuh's
timeline view. pfSense acts as the internal NTP authority; every VM points at
pfSense rather than the public internet directly.

## DNS design
- VLAN 30 (domain-joined machines) point at the AD DC (10.10.30.10) for
  AD-integrated DNS (Kerberos/SYSVOL/GPO depend on this)
- AD DC forwards external queries to pfSense's resolver (10.10.30.1)
- VLANs 10/20/40 use pfSense's DNS Resolver directly

## Traffic mirroring (honest limitation noted)
No physical SPAN port exists on a single-host Proxmox setup. Mirroring is
implemented via Linux `tc` mirred rules copying ingress traffic from the
monitored VLAN's tap interface to the sensor VM's second (promiscuous) NIC.
This is documented explicitly as a software approximation of a hardware TAP,
not identical to it — see `infrastructure/proxmox/mirror-setup.md`.

```bash
tc qdisc add dev tap100i2 ingress
tc filter add dev tap100i2 parent ffff: \
  protocol all u32 match u32 0 0 \
  action mirred egress mirror dev tap150i0
```

Wrapped in a systemd oneshot unit since tap interfaces are ephemeral across reboots.

## Verification
- `chronyc sources` on Ubuntu shows synced source against pfSense
- DNS lookups resolve both internal (soclab.local) and external names
- `w32tm /query /status` on Windows shows correct time source (once Mode A up)
- `tcpdump` on the sensor's mirrored interface shows VLAN 30 test traffic
