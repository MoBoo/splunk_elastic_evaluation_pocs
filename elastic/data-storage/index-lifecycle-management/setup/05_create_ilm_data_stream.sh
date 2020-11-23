echo ">>> Create Index-Lifecycle-Management Policy: timeseries_policy"
curl -XPUT "http://localhost:9200/_ilm/policy/timeseries_policy?pretty" -H 'Content-Type: application/json' -d'
{
  "policy": {
    "phases": {
      "hot": {
        "actions": {
          "rollover": {
            "max_size": "750MB",
            "max_age": "5m"
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
          "delete": {}
        }
      }
    }
  }
}
';echo

echo ">>> Create Index-Template/Data Stream: timeseries_template with timeseries_policy applied"
curl -XPUT "http://localhost:9200/_index_template/timeseries_template?pretty" -H 'Content-Type: application/json' -d'
{
  "index_patterns": ["timeseries"],
  "data_stream": { },
  "template": {
    "settings": {
      "number_of_shards": 1,
      "number_of_replicas": 0,
      "index.lifecycle.name": "timeseries_policy"
    }
  }
}
';echo

curl -XPOST "http://localhost:9200/timeseries/_doc?pretty" -H 'Content-Type: application/json' -d'
{
  "message": "test request",
  "@timestamp": "1605521542"
}
';echo

#curl -XGET "http://localhost:9200/.ds-timeseries-*/_ilm/explain?pretty"
