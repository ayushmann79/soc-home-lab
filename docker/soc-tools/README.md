# SOC Tools Stack (VM 121, 10.10.20.11)

TheHive + Cortex + MISP + Shuffle, consolidated into one Docker Compose file
to fit the lab's RAM budget instead of running 4 separate VMs.

## Bring up TheHive + Cortex (persistent during Mode C)
```bash
cp .env.example .env   # fill in real secrets, never commit .env
docker compose up -d cassandra elasticsearch-thehive thehive cortex
```

## Bring up MISP (only when actively curating IOCs)
```bash
docker compose up -d misp-db misp
```

## Bring up Shuffle (only when building/testing a playbook)
```bash
docker compose up -d shuffle-backend shuffle-frontend
```

## Wazuh integration
See `wazuh-thehive-integration.md` for wiring Wazuh alerts into TheHive
case creation.

## Cortex analyzers
Configure VirusTotal, AbuseIPDB, and MISP lookup analyzers (free-tier API
keys stored in `.env`). Link Cortex as a Cortex server in TheHive under
Admin > Organization > Cortex.
