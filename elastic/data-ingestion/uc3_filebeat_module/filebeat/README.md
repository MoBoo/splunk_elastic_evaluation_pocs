# Filebeat Configuration ([filebeat.yml](filebeat.yml))
Filebeat is configured use the [apache-module](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-module-apache.html) to monitor the local `access.log`-file in `/usr/share/data/`, which is a mounted volume by docker.
The read file content is the send to elasticsearch for further processing and finally indexing.

```
filebeat.modules:  <- define the filebeat module
- module: apache   <- which module to use
  access:          <- enable the apache.access submodule
    enabled: true
    var.paths: ["/usr/share/data/access.log"]  <- define which file to monitor


output.elasticsearch:  <- output data to elasticsearch
  hosts: ["elasticsearch:9200"]
  username: "${ELASTIC_USERNAME}"  <- optional, used when a user:password is required by elasticsearch
  password: "${ELASTIC_PASSWORD}"  <- optional, used when a user:password is required by elasticsearch

setup.kibana:  <- define the kibana-server used in filebeat module setup.
  host: "kibana:5601"
```
