# Points a Windows host's time service at pfSense (internal NTP authority)
$PfSenseGw = "10.10.30.1"

w32tm /config /manualpeerlist:"$PfSenseGw" /syncfromflags:manual /reliable:yes /update
Restart-Service w32time
w32tm /resync
w32tm /query /status
