#!/bin/bash
#echo ">>> Removing Enrich policy: http_status_code_policy"
#/usr/bin/curl -X DELETE "localhost:9200/_enrich/policy/http_status_code_policy?pretty=true";echo

echo ">>> Create enrich policy: http_status_code_policy"
curl -X PUT -H "Content-Type: application/json" "localhost:9200/_enrich/policy/http_status_code_policy?pretty=true" -d'
{
  "match": {
    "indices": "http_status_code_mapping",
    "match_field": "status_code",
    "enrich_fields": ["status_desc"]
  }
}';echo

echo ">>> Execute enrich policy: http_status_code_policy"
curl -X POST -H "Content-Type: application/json" "localhost:9200/_enrich/policy/http_status_code_policy/_execute?pretty=true";echo

