#!/bin/bash
echo ">>> Create kibana index-pattern: http_access_logs_pattern"
curl -X POST "localhost:5601/api/saved_objects/index-pattern/http_access_logs_pattern"  -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '
{
  "attributes": {
    "title": "http_access_logs*",
    "timeFieldName: "timestamp"
  }
}';echo
