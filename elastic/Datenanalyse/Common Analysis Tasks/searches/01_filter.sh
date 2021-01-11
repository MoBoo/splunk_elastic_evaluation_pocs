# Field-value match
echo ">>> Search: Field-Value Match"
curl -XGET "http://localhost:9200/http_access_logs_summary/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "term": {
      "http.request.method.keyword": {
        "value": "GET"
      }
    }
  }
}';echo

# Only return events, who have a field specified
echo ">>> Search: Events where a field is defined"
curl -XGET "http://localhost:9200/http_access_logs_summary/_search?pretty" -H 'Content-Type: application/json' -d'{  "query": {    "exists": {"field": "message"}  }}';echo

# string match
echo ">>> Search: String match"
curl -XGET "http://localhost:9200/http_access_logs_summary/_search?pretty" -H 'Content-Type: application/json' -d'{  "query": {    "match": {      "message": "categoryId"    }  }}';echo

# selection
echo ">>> Search: Range-Selection"
curl -XGET "http://localhost:9200/http_access_logs_summary/_search?pretty" -H 'Content-Type: application/json' -d'{  "query": {    "range": {      "http.response.status_code": {        "gte": 300,        "lt": 500      }    }  }}';echo
