#!/bin/bash
echo ">>> Removing Index: http_access_logs"
/usr/bin/curl -X DELETE "localhost:9200/http_access_logs?pretty=true";echo

echo ">>> Removing Pipeline: access_combined_wcookie_parsing_pipeline"
/usr/bin/curl -X DELETE "localhost:9200/_ingest/pipeline/access_combined_wcookie_parsing_pipeline?pretty";echo

