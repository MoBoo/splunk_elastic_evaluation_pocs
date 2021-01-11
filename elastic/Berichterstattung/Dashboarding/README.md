# Overview
This PoC shows the usage of a dashboard in kibana. For this example a http-report dashboard is created. It shows some metrics and kpi from the ingested http data by filebeat.
The dashboard can be found using the kibana ui: `Stack Management > [Kibana] Saved Objects > 	HTTP Demo Dashboard`

![HTTP Dashboard](docs/dashboard.png)

This PoC uses Filebeat and an [Ingest-Pipeline](https://www.elastic.co/guide/en/elasticsearch/reference/current/ingest.html) as the main ingesting component.

![Overview](docs/uc9_ingest_pipeline.png)

This PoC uses [scripted-fields](https://www.elastic.co/guide/en/kibana/current/scripted-fields.html) to map `http status codes` to `status code text`.
This is usually done via the Kibana-Web-Interface and then automatically applied by kibana at search time.

In this PoC Filebeat is used to monitor the `/usr/share/data/accesss.log`-file on the local filesystem and output the data to elasticsearch.
When Elasticsearches receives data, the data is then processed using the defined ingest-pipeline in the [filebeat.yml](filebeat/filebeat.yml)
During processing the `message` field is parsed using a `grok` filter to extract field values.

# Usage
To run the PoC simply execute the `run.sh` script. It will start all the docker-container and apply runtime configuration, aswell as output log messages and cleanup after you exit.
## Runtime Configuration
Elasticsearch and Kibana uses a custom runtime configuration to create an [index-template](https://www.elastic.co/guide/en/elasticsearch/reference/master/index-templates.html), the ingest-pipeline and an [index-pattern](https://www.elastic.co/guide/en/kibana/master/index-patterns.html).
This configuration is created when starting the docker-environment using the `run.sh` script.
The scripts used to perform runtime object creation can be found in the [setup](setup)-directory.
- `00_cleanup.sh`: cleanes up index-templates, pipelines, etc. from previous runs.
- `01_create-index.sh`: Creates an index-template called `http_access_logs_template`, which is applied to every created index, which matches the pattern `http_access_logs*`. Defines index-settings, such as `number_of_shards`, `number_of_replicas` and [field-mappings](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping.html).
- `02_create-pipeline`: Creates the ingest-pipeline used to parse log events before they get indexed by elasticsearch.
- `03_create_kibana_index_pattern.sh`: Creates a kibana-index-pattern, which matches all `http_access_logs*`-indexes and sets the `timeFieldName` to `timestamp`.
- `04_import_kibana_objects.sh`: Imports saved kibana objects from the `kibana-export` directory.
