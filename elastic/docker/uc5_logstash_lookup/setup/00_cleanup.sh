#!/bin/bash
echo ">>> Removing Index: http_access_logs"
/usr/bin/curl -X DELETE "localhost:9200/http_access_logs?pretty=true";echo

echo ">>> Removing Index-Template: http_access_logs_template"
/usr/bin/curl -X DELETE "localhost:9200/_template/http_access_logs_template?pretty=true";echo
