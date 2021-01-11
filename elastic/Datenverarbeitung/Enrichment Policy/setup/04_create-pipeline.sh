#!/bin/bash
#echo ">>> Removing Pipeline: http_status_code_lookup"
#/usr/bin/curl -X DELETE "localhost:9200/_ingest/pipeline/http_status_code_lookup?pretty=true";echo

echo ">>> Creating Pipeline: http_status_code_lookup"
/usr/bin/curl -H "Content-Type: application/json" -X PUT "localhost:9200/_ingest/pipeline/http_status_code_lookup?pretty=true" -d '
{
  "description" : "Parses 'access_combined_wcookie'-Logs and enriches http status code descriptions.",
  "processors" : [
    {
       "grok": {
         "field": "message",
         "pattern_definitions": {
           "HTTPVERSION": "HTTP(/|\\s)%{NUMBER}",
           "HTTPDATE": "%{MONTHDAY}/%{MONTH}/%{YEAR}:%{TIME}((\\s%{ISO8601_TIMEZONE})?)"
         },
         "patterns": ["%{IPORHOST:client.address} %{USERNAME:client.ident} %{USERNAME:user.name} \\[%{HTTPDATE:timestamp}\\] \"%{WORD:http.request.method} %{NOTSPACE:http.request.content} %{HTTPVERSION:http.version}\" %{INT:http.response.status_code} %{INT:http.response.bytes} \"%{DATA:http.request.referrer}\" \"%{DATA:user_agent.original}\"" ],
         "ignore_missing": true
       }
    },
    {
      "enrich" : {
        "policy_name": "http_status_code_policy",
        "field" : "http.response.status_code",
        "target_field": "http.response.status_desc",
        "max_matches": "1"
      }
    }
  ],
  "on_failure": [
    {
      "set": {
        "field": "_index",
        "value": "failed-{{ _index }}"
      }
    }
  ]
}';echo
