#!/bin/bash

source .env

#echo ">>> Removing Index: http_access_logs"
#/usr/bin/curl -X DELETE --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD "localhost:9200/http_access_logs?pretty=true";echo

echo ">>> Creating Index Template: http_access_logs_template"
/usr/bin/curl -H "Content-Type: application/json" -X PUT --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD "localhost:9200/_index_template/http_access_logs_template?pretty=true" -d '
{
  "index_patterns": ["logs-http_access_logs-*"],
  "priority": 200,
  "template": {
    "settings": {
      "number_of_shards": 1,
      "number_of_replicas": 0,
      "index" : {
            "default_pipeline" : "access_combined_wcookie_parsing_pipeline" 
       }
    },
    "mappings": {
      "dynamic": "true",
      "properties": {
        "client.address":{
			"type":"keyword"
		},
		"client.ident":{
			"type":"keyword"
		},
		"user.name":{
			"type":"keyword"
		},
		"http.request.method":{
			"type":"keyword"
		},
		"http.response.status_code":{
			"type":"long"
		},
		"http.response.bytes":{
			"type":"long"
		},
		"http.request.referrer":{
			"type": "text",
			"fields": {
                          "keyword" : {
				"type": "keyword"
                          }
			}
		},
		"user_agent.original":{
			"type":"text"
		},
		"http.version":{
			"type":"keyword"
		},
		"tags":{
			"type":"keyword"
		},
                "timestamp":{
			"type":"date",
			"format":"dd/MMM/yyyy:HH:mm:ss Z"
		}
      }
    },
    "aliases": {
      "http_access_logs_summary": { }
    }
  },
  "_meta": {
    "description": "Index Template for custom http_access_logs."
  }
}';echo

#echo ">>> Creating Index: http_access_logs"
#/usr/bin/curl -H "Content-Type: application/json" -X PUT --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD "localhost:9200/http_access_logs?pretty=true";

