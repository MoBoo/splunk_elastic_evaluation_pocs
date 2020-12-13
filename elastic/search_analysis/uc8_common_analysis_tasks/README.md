# Overview
This PoC shows a sample or queries, typically used in log analysis. Those queries are stored as kibana objects so they can easily be accessed via the kibana UI: `Stack Management -> [Kibana] Saved Objects` or maually execute via the scripts stored in the [searches](searches) directory.

![Overview](docs/uc8_ingest_pipeline.png)

This PoC uses Filebeat and an [Ingest-Pipeline](https://www.elastic.co/guide/en/elasticsearch/reference/current/ingest.html) as the main ingesting component.

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

## Run searches manually
Scripts are stored in the [searches](searches) directory.
Those scripts are used to manually run the searches via curl which otherwise are already imported in kibana.
Searches include:
- Filtering data by key value matches. E.g. `http.request.method==GET` (see [01_filter.sh](searches/01_filter.sh))
- Aggregating data by diffrent fields or multiple fields (see [03_aggregation.sh](searches/03_aggregation.sh))
- Filter search output to specific fields only. (see [05_filter_columns.sh](searches/05_filter_columns.sh))
- Adding fields ([02_add_column.sh](searches/02_add_column.sh)) during searchtime cannot be done currently. One option could be to use kibana [scripted-fields](https://www.elastic.co/guide/en/kibana/current/scripted-fields.html). Also see [uc7_scripted_fields](../uc7_scripted_fields). Currently in beta phase are [runtime fields](https://www.elastic.co/guide/en/elasticsearch/reference/7.x/runtime.html). Those are not part of this PoC, but could provide a valueable addition in the future.
- Renameing Fields ([04_rename_column.sh](searches/04_rename_column.sh)): Currently cannot be done during search.
