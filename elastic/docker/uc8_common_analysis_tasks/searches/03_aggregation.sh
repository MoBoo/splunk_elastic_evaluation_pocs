# Number of request by http_method
curl -XGET "http://localhost:9200/http_access_logs_summary/_search?pretty" -H 'Content-Type: application/json' -d'{  "size": 0,  "_source": true,  "aggs": {    "request_methods_usage": {      "terms": {        "field": "http.request.method"      }    }  }}';echo

# Number of requests by user_agents and http_method
curl -XGET "http://localhost:9200/http_access_logs_summary/_search?pretty" -H 'Content-Type: application/json' -d'{  "size": 0,  "_source": true,  "aggs": {    "request_methods_usage": {      "terms": {        "field": "http.request.method"      },      "aggs": {        "user_agends": {          "terms": {            "field": "user_agent.original.keyword"          }        }      }    }  }}'

# Sum of Bytes transmitted per http_method
curl -XGET "http://localhost:9200/http_access_logs_summary/_search?pretty" -H 'Content-Type: application/json' -d'{  "size": 0,  "_source": true,  "aggs": {    "request_methods_usage": {      "terms": {        "field": "http.request.method"      },      "aggs": {        "sum_bytes": {          "sum": {            "field": "bytes"          }        }      }    }  }}'