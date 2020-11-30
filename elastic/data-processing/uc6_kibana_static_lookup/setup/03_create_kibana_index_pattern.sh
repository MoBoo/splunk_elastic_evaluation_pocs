#!/bin/bash
echo ">>> Create kibana index-pattern: http_access_logs_pattern"
curl -X POST "localhost:5601/api/saved_objects/index-pattern/http_access_logs_pattern"  -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '
{
  "attributes": {
    "title": "http_access_logs*",
    "timeFieldName": "timestamp",
      "fieldFormatMap":"{\"http.response.status_code\":{\"id\":\"static_lookup\",\"params\":{\"parsedUrl\":{\"origin\":\"http://localhost:5601\",\"pathname\":\"/app/management/kibana/indexPatterns\",\"basePath\":\"\"},\"lookupEntries\":[{\"key\":\"200\",\"value\":\"OK\"},{\"key\":\"404\",\"value\":\"Not Found\"},{\"key\":\"400\",\"value\":\"Bad Request\"},{\"key\":\"500\",\"value\":\"Internal Server Error\"}],\"unknownKeyValue\":\"n/a\"}}}"
  }
}';echo
