# Filebeat Configuration ([filebeat.yml](filebeat.yml))
Filebeat is configured to monitor the local `access.log`-file in `/usr/share/data/`, which is a mounted volume by docker.
The read file content is the send to logstash for further processing and finally indexing in elasticsearch.

```

filebeat.inputs:
- type: log
  paths:
    - /usr/share/data/access.log
  index: "http_access_logs-filebeat-%{[agent.version]}-%{+yyyy.MM.dd}"  <- sets a custom index, instead of the default 'filebeat-<version>-<date>'
  processors:
    - add_tags:
        tags: ["access_combined_wcookie"]  <- add a custom tags to describe the log data. This information is later used by logstash for processing.

output.logstash:  <- send data to logstash on 'logstash:5044'
  hosts: ["logstash:5044"]
```
