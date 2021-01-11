#!/bin/bash

source .env

# Create Configuration
echo ">>> Create Configuration: http_access_logs_conf"
conf_id=$(curl -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true" "http://localhost:5601/api/ingest_manager/agent_configs?sys_monitoring=true" --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD --silent -d '
{
   "name":"http_access_logs_conf",
   "description":"",
   "namespace":"default",
   "monitoring_enabled":[
      "logs",
      "metrics"
   ]
}' | jq .item.id | xargs)

echo "$conf_id"

# Add Integration to Configuration
echo ">>> Add Integration: access_logs to Configuration: $conf_id"
curl -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true" "http://localhost:5601/api/ingest_manager/package_configs" --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD --silent -d'
{
   "name":"access_logs",
   "description":"",
   "namespace":"default",
   "config_id":"'"$conf_id"'",
   "enabled":true,
   "output_id":"",
   "inputs":[
      {
         "type":"logfile",
         "enabled":true,
         "streams":[
            {
               "id":"logfile-log",
               "enabled":true,
               "data_stream":{
                  "type":"logs",
                  "dataset":"log"
               },
               "vars":{
                  "paths":{
                     "type":"text",
                     "value":[
                        "/usr/share/data/access.log"
                     ]
                  },
                  "data_stream.dataset":{
                     "type":"text",
                     "value":"http_access_logs"
                  },
                  "custom":{
                     "value":"",
                     "type":"yaml"
                  }
               }
            }
         ]
      }
   ],
   "package":{
      "name":"log",
      "title":"Custom logs",
      "version":"0.3.5"
   }
}'

echo ""

# Assign new Configuration to Agent
# 1. get elastic-agent id
agent_id=$(curl -X GET -H "Content-Type: application/json" -H "kbn-xsrf: true" "http://localhost:5601/api/ingest_manager/fleet/agents" --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD | jq .list[0].id | xargs)

echo ">>> Assign Configuration to Agent: $agent_id"
curl -X PUT -H "Content-Type: application/json" -H "kbn-xsrf: true" "http://localhost:5601/api/ingest_manager/fleet/agents/$agent_id/reassign" --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD -d '
{
   "config_id":"'"$conf_id"'"
}'
