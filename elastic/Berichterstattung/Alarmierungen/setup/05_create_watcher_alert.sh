# This alert has no productive value. It searches over the last years data EVERY time. This is just for demo purposes.
echo ">>> Create Watcher Alert"
curl -XPUT "http://elasticsearch:9200/_watcher/watch/800349c6-3102-4848-b802-0bfed6cc8d5f" -H 'Content-Type: application/json' -d'
{
  "trigger": {
    "schedule": {
      "interval": "1m"
    }
  },
  "input": {
    "search": {
      "request": {
        "search_type": "query_then_fetch",
        "indices": [
          "http_access_logs*"
        ],
        "rest_total_hits_as_int": true,
        "body": {
          "size": 0,
          "query": {
            "bool": {
              "filter": [
                {
                  "range": {
                    "@timestamp": {
                      "gte": "now-1h"
                    }
                  }
                },
                {
                  "range": {
                    "http.response.status_code": {
                      "gte": 500
                    }
                  }
                }
              ]
            }
          }
        }
      }
    }
  },
  "condition": {
    "compare": {
      "ctx.payload.hits.total": {
        "gte": 100
      }
    }
  },
  "actions": {
    "my-logging-action": {
      "logging": {
        "level": "info",
        "text": "There are {{ctx.payload.hits.total}} documents in your index. Threshold is 10."
      }
    }
  },
  "metadata": {
    "xpack": {
      "type": "json"
    },
    "name": "HTTP Server Error Alert"
  }
}';echo
