# Filebeat Configuration ([filebeat.yml](filebeat.yml))
Filebeat is configured to monitor the local `access.log`-file in `/usr/share/data/`, which is a mounted volume by docker.
The read file content is the send to elasticsearch for further processing and finally indexing.

```
filebeat.inputs:
- type: log
  paths:
    - /usr/share/data/access.log
  index: "http_access_logs-filebeat-%{[agent.version]}-%{+yyyy.MM.dd}"  <- sets a custom index, instead of the default 'filebeat-<version>-<date>'
  pipeline: "access_combined_wcookie_parsing_pipeline"  <- defines the ingest-pipeline to use for indexing
  processors:
    - add_tags:
        tags: ["access_combined_wcookie"]  <- add a custom tags to describe the log data.

output.elasticsearch:
  hosts: ["elasticsearch:9200"]
  username: "${ELASTIC_USERNAME}"  <- optional, used when a user:password is required by elasticsearch
  password: "${ELASTIC_PASSWORD}"  <- optional, used when a user:password is required by elasticsearch
```
