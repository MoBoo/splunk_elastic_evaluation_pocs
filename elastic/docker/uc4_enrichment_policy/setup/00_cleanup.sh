#!/bin/bash
echo ">>> Removing Index: http_status_codes_mapping"
/usr/bin/curl -X DELETE "localhost:9200/http_status_codes_mapping?pretty=true";echo

echo ">>> Removing Pipeline: http_status_code_lookup"
/usr/bin/curl -X DELETE "localhost:9200/_ingest/pipeline/http_status_code_lookup?pretty=true";echo

echo ">>> Removing Enrich policy: http_status_code_policy"
/usr/bin/curl -X DELETE "localhost:9200/_enrich/policy/http_status_code_policy?pretty=true";echo

echo ">>> Removing Index: http_access_logs"
/usr/bin/curl -X DELETE "localhost:9200/http_access_logs?pretty=true";echo
