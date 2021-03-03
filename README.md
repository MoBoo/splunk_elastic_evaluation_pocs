# Proof-of-Concepts: Splunk and Elastic Evaluation
## PoC Overview
| Wertschöpfungsphase | Splunk | Elastic |
|-|-|-|
| Dateneingabe | [Data Onboarding UF](splunk/Dateneingabe/Data%20Onboarding%20UF) | [Ingest Pipeline](elastic/Dateneingabe/Ingest%20Pipeline) |
|  | [Data Onboarding HF](splunk/Dateneingabe/Data%20Onboarding%20HF) | [Filebeat Modules](elastic/Dateneingabe/Filebeat%20Modules) |
|  |  | [Logstash Pipeline](elastic/Dateneingabe/Logstash%20Pipeline) |
|  |  | [Elastic Agents Fleet](elastic/Dateneingabe/Elastic%20Agents%20Fleet) |
| Datenverarbeitung | [Custom Sourcetype Fieldextractions](splunk/Datenverarbeitung/Custom%20Sourcetype%20Fieldextractions) | [Enrichment Policy](elastic/Datenverarbeitung/Enrichment%20Policy) |
|  | [CIM Normalisierung](splunk/Datenverarbeitung/CIM%20Normalisierung) | [Logstash Lookup](elastic/Datenverarbeitung/Logstash%20Lookup) |
|  | [Lookups](splunk/Datenverarbeitung/Lookups) | [Kibana Static Lookup](elastic/Datenverarbeitung/Kibana%20Static%20Lookup) |
| Datenspeicherung | [Index Lifecycle Management](splunk/Datenspeicherung/Index%20Lifecycle%20Management) | [Index Lifecycle Management](elastic/Datenspeicherung/Index%20Lifecycle%20Management) |
| Datenanalyse | [Common Analysis Tasks](splunk/Datenanalyse/Common%20Analysis%20Tasks) | [Common Analysis Tasks](elastic/Datenanalyse/Common%20Analysis%20Tasks) |
|  |  | [Scripted Fields](elastic/Datenanalyse/Scripted%20Fields) |
| Berichterstattung | [Dashboarding](splunk/Berichterstattung/Dashboarding) | [Dashboarding](elastic/Berichterstattung/Dashboarding) |
|  | [Alarmierungen](splunk/Berichterstattung/Alarmierungen) | [Alarmierungen](elastic/Berichterstattung/Alarmierungen) |
## System Requirements
This repository was developed and tested on an Ubuntu 20.04 Virtual Machine with 4 CPU-Cores and 8GB RAM. 
## Dependencies
Either `root` or `sudo` priviledges are required to run the pocs. 
This is due to changes to file-permission, when files are mounted into the splunk docker environment and cleanup. (see [reset_permissions.sh](splunk/scripts/reset_permissions.sh))
### Docker
Follow the instructions on the official docker documentation: [Docker Linux Installation](https://docs.docker.com/engine/install/ubuntu/)

### Docker Compose
Follow the instructions on the official docker documentation: [Install Docker Compose](https://docs.docker.com/compose/install/)

### Add your user to `docker` group
1. Create `docker` group: `$ sudo groupadd docker`.
2. Add current user to `docker` group: `$ sudo usermod -aG docker $USER`
3. Log out and log back in or reload group changes with: `$ newgrp docker`

Test and verify your user is able to run docker: `$ docker run hello-world`

Taken from [Docker Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)

# Quickstart
Download or clone the github repository on your machine.
```
$ git clone https://github.com/MoBoo/splunk_elastic_evaluation_pocs.git
$ cd splunk_elastic_evaluation_pocs
```

PoCs are organized in directories based on the value-chain:
```
.
├── elastic
│   └── <process_step>
│       └── <pocs>
|           ├── README.md
|           └── run.sh
└── splunk
   ├── <process_step>
   │   └── <pocs>
   |       ├── README.md
   |       └── run.sh
   └── scripts
```
The `README` gives an overview for each poc.

To run a PoC go to the desired PoC-directory and execute the `run.sh` script:

```
$ cd elastic/Dateneingabe/Ingest Pipeline
$ ./run.sh
>>> Starting docker environment.
...

>>> Waiting for elasticsearch to become available. This may take a while.
...

>>> Waiting for kibana to become available. This may take a while.
...

>>> Running setup scripts.
...

Building filebeat
...

>>> Setup completed. Start streaming docker logs. (Ctrl+C to exit.)
[docker log streaming]
```

For Splunk PoCs open `localhost:8000`

For Elastic PoCs open `localhost:9200` for `Elasticsearch` or `localhost:5601` for `Kibana`

## Credentials
If needed for poc (see `.env` in each poc-directory)
```
Splunk Enterprise (+ Heavy Forwarder): 
    Nutzer: admin
    Passwort: ADMIN_SI_PASSWORD
Splunk Universal Forwarder: 
    Nutzer: admin
    Passwort: ADMIN_UF_PASSWORD
    
Elasticstack (every component):
    Nutzer: elastic
    Passwort: SECURE_ELK_PASSWORD
```
