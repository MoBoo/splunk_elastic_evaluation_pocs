# Proof-of-Concepts: Splunk and Elastic Evaluation
## Dependencies
Either `root` or `sudo` priviledges are required to run the pocs. 
This is due to changes to file-permission, when files are mounted into the splunk docker environment and cleanup. (see [reset_permissions.sh](splunk/scripts/reset_permissions.sh))
### Docker
Follow the instructions on the official docker documentation: [Docker Linux Installation](https://docs.docker.com/engine/install/ubuntu/)

### Docker Compose
Follow the instructions on the official docker documentation: [Install Docker Compose](https://docs.docker.com/compose/install/)

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
