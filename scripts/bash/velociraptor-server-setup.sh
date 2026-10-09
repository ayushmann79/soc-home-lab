#!/bin/bash
# Sets up the Velociraptor server on VM 160 (10.10.20.x)
set -euo pipefail

wget https://github.com/Velocidex/velociraptor/releases/latest/download/velociraptor-linux-amd64
chmod +x velociraptor-linux-amd64
./velociraptor-linux-amd64 config generate > server.config.yaml
./velociraptor-linux-amd64 --config server.config.yaml frontend &

echo "Velociraptor server started. Deploy client MSI/binary to Windows/Ubuntu"
echo "endpoints, pointed at 10.10.20.x:8000."
