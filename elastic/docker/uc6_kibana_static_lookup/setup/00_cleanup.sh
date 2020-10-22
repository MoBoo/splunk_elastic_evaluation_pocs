#!/bin/bash
echo ">>> Removing kibana index-pattern: http_access_logs_pattern"
/usr/bin/curl -H "kbn-xsrf: true" -X DELETE "localhost:5601/api/saved_objects/index-pattern/http_access_logs_pattern";echo

echo ">>> Removing Pipeline: access_combined_wcookie_parsing_pipeline"
/usr/bin/curl -X DELETE "localhost:9200/_ingest/pipeline/access_combined_wcookie_parsing_pipeline?pretty=true";echo

echo ">>> Removing Index: http_access_logs"
/usr/bin/curl -X DELETE "localhost:9200/http_access_logs?pretty=true";echo
