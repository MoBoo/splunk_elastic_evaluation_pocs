#!/bin/bash
#echo ">>> Removing Index: http_status_codes_mapping"
#/usr/bin/curl -X DELETE "localhost:9200/http_status_codes_mapping?pretty=true";echo

echo ">>> Creating Index: http_status_codes_mapping"
/usr/bin/curl -H "Content-Type: application/json" -X PUT "localhost:9200/http_status_codes_mapping?pretty=true";echo

echo ">>> Insert Lookup Data"
/usr/bin/curl -H "Content-Type: application/json" -X POST "localhost:9200/http_status_code_mapping/_bulk?pretty=true&refresh=wait_for" --data-binary "@setup/http_status_code_data.bulk";echo

