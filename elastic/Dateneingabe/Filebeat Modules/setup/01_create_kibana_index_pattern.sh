#!/bin/bash
echo ">>> Create kibana index-pattern: filebeat_pattern"
curl -X POST "localhost:5601/api/saved_objects/index-pattern/filebeat_pattern"  -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '
{
  "attributes": {
    "title": "filebeat*",
    "timeFieldName": "@timestamp"
  }
}';echo
