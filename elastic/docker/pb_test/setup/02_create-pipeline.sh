#!/bin/bash
#echo ">>> Removing Pipeline: access_combined_wcookie_parsing_pipeline"
#/usr/bin/curl -X DELETE "localhost:9200/_ingest/pipeline/access_combined_wcookie_parsing_pipeline?pretty=true";echo

echo ">>> Creating Pipeline: access_combined_wcookie_parsing_pipeline"
/usr/bin/curl -H "Content-Type: application/json" -X PUT "localhost:9200/_ingest/pipeline/access_combined_wcookie_parsing_pipeline?pretty=true" -d '
{
  "description": "This pipeline parses 'access_combined_wcookie' logs.",
  "processors": [
    {
      "script": {
        "lang": "painless",
        "source": "ctx[\"pb\"]=[:]; ctx[\"pb\"][\"ingest\"]=[:]; ctx[\"pb\"][\"ingest\"][\"input\"] = new Date().getTime()"
      }
    },
    {
      "grok": {
        "field": "message",
        "pattern_definitions": {
          "HTTPVERSION": "HTTP(/|\\s)%{NUMBER}",
          "HTTPDATE": "%{MONTHDAY}/%{MONTH}/%{YEAR}:%{TIME}((\\s%{ISO8601_TIMEZONE})?)"
        },
        "patterns": [
          "%{IPORHOST:client.address} %{USERNAME:client.ident} %{USERNAME:user.name} \\[%{HTTPDATE:timestamp}\\] \"%{WORD:http.request.method} %{NOTSPACE:http.request.content} %{HTTPVERSION:http.version}\" %{INT:http.response.status_code} %{INT:http.response.bytes} \"%{DATA:http.request.referrer}\" \"%{DATA:user_agent.original}\""
        ],
        "ignore_missing": true
      }
    },
    {
      "date": {
        "field": "timestamp",
        "formats": [
          "dd/MMM/yyyy:HH:mm:ss",
          "dd/MMM/yyyy:HH:mm:ss Z"
        ]
      }
    },
    {
      "script": {
        "lang": "painless",
        "source": "ctx[\"pb\"][\"ingest\"][\"output\"] = new Date().getTime(); ctx[\"pb\"][\"ingest\"][\"processing_time_ms\"] = ctx[\"pb\"][\"ingest\"][\"output\"] - ctx[\"pb\"][\"ingest\"][\"input\"]"
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
