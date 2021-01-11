#!/bin/bash
#echo ">>> Removing Pipeline: access_combined_wcookie_parsing_pipeline"
#/usr/bin/curl -X DELETE "localhost:9200/_ingest/pipeline/access_combined_wcookie_parsing_pipeline?pretty=true";echo

echo ">>> Creating Pipeline: access_combined_wcookie_parsing_pipeline"
/usr/bin/curl -H "Content-Type: application/json" -X PUT "localhost:9200/_ingest/pipeline/access_combined_wcookie_parsing_pipeline?pretty=true" -d '
{
  "description": "This pipeline parses 'access_combined_wcookie' logs.",
  "processors": [
    {
      "grok": {
        "field": "message",
        "pattern_definitions": {
          "HTTPVERSION": "HTTP(/|\\s)%{NUMBER}",
          "HTTPDATE": "%{MONTHDAY}/%{MONTH}/%{YEAR}:%{TIME}((\\s%{ISO8601_TIMEZONE})?)"
        },
        "patterns": [ "%{IPORHOST:client.address} %{USERNAME:client.ident} %{USERNAME:user.name} \\[%{HTTPDATE:timestamp}\\] \"%{WORD:http.request.method} %{NOTSPACE:http.request.content} %{HTTPVERSION:http.version}\" %{INT:http.response.status_code} %{INT:http.response.bytes} \"%{DATA:http.request.referrer}\" \"%{DATA:user_agent.original}\"" ],
        "ignore_missing": true
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
