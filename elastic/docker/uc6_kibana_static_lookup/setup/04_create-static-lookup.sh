#!/bin/bash
echo ">>> Create kibana index-pattern: http_access_logs_pattern"
curl -X POST "localhost:5601/api/saved_objects/index-pattern/http_access_logs_pattern"  -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '
{
  "attributes": {
    "title": "http_access_logs*"
  }
}';echo


echo ">>> Creating kibana index-pattern static lookup for field: http.response.status_code"
/usr/bin/curl -H "Content-Type: application/json" -H "kbn-xsrf: true" -X PUT "localhost:5601/api/saved_objects/index-pattern/http_access_logs_pattern" -d '
{
        "attributes": {
                "fieldFormatMap": "{\"http.response.status_code\": {\"id\":\"static_lookup\",\"params\":{\"lookupEntries\":[{\"key\":\"200\",\"value\":\"OK\"},{\"key\":\"404\",\"value\":\"Not Found\"},{\"key\":\"400\",\"value\":\"Bad Request\"},{\"key\":\"500\",\"value\":\"Internal Server Error\"}],\"unknownKeyValue\":\"n/a\"}}}"}
}';echo
