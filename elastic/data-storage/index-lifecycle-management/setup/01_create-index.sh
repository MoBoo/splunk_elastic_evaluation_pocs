#!/bin/bash
#echo ">>> Removing Index: http_access_logs"
#/usr/bin/curl -X DELETE "localhost:9200/http_access_logs?pretty=true";echo

echo ">>> Create ILM-Policy: http_access_logs_policy"
curl -H "Content-Type: application/json" -X PUT "localhost:9200/_ilm/policy/http_access_logs_policy" -d '
{
  "policy": {
    "phases": {
      "hot": {
        "min_age": "0ms",
        "actions": {
          "rollover": {
            "max_age": "2m",
            "max_size": "750mb"
          },
          "set_priority": {
            "priority": 100
          }
        }
      },
      "warm": {
        "actions": {
          "set_priority": {
            "priority": null
          }
        }
      },
      "delete": {
        "min_age": "5m",
        "actions": {
          "delete": {
            "delete_searchable_snapshot": true
          }
        }
      }
    }
  }
}
';echo

echo ">>> Creating Index Template: http_access_logs_template"
/usr/bin/curl -H "Content-Type: application/json" -X PUT "localhost:9200/_index_template/http_access_logs_template?pretty=true" -d '
{
"index_patterns": ["http_access_logs*"],
  "template": {
    "settings": {
      "number_of_shards": 1,
      "number_of_replicas": 0,
      "index.lifecycle.name": "http_access_logs_policy",
      "index.lifecycle.rollover_alias": "http_access_logs_summary"
    },
    "mappings": {
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
		"type":"text",
		"fields": {
		  "keyword": {
		  	"type": "keyword"
		  }
		}
	},
	"http.version":{
		"type":"keyword"
	},
	"tags":{
		"type":"keyword"
	},
        "timestamp":{
		"type":"date",
		"format":"dd/MMM/yyyy:HH:mm:ss"
	}
      }
    }
  },
  "_meta": {
    "description": "Index Template for custom http_access_logs."
  }
}';echo

echo ">>> Creating Index: http_access_logs-000001"
curl -H "Content-Type: application/json" -X PUT "localhost:9200/http_access_logs-000001?pretty=true" -d'
{
  "aliases": {
    "http_access_logs_summary": {
      "is_write_index": true
    }
  }
}
';echo
