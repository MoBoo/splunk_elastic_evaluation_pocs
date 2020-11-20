#!/bin/bash

# Already handled by elastic-agent dockerfile. Can be deleted.

# Prevent Execution
exit

# Load Environment Variables
source .env

echo ">>> Enable Fleet"
curl -X POST -H "Content-Type: application/json" -H "kbn-xsrf: true" "http://localhost:5601/api/ingest_manager/fleet/setup?pretty" --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD -d '
{"forceRecreate":true}
';echo

sleep 1

echo ">>> Query available Enrollment API Keys"
fleet_enrollment_api_key_id=$(curl -X GET -H "kbn-xsrf: true" --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD --silent "http://localhost:5601/api/ingest_manager/fleet/enrollment-api-keys" | jq .list[0].id | xargs)

sleep 1

echo ">>> Query Enrollment API Key: ${fleet_enrollment_api_key_id[@]}"
curl -X GET -H "kbn-xsrf: true" --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD --silent "http://localhost:5601/api/ingest_manager/fleet/enrollment-api-keys/${fleet_enrollment_api_key_id[@]}" | jq .item.api_key | xargs > fleet_enrollment_api_key

echo "Fleet Enrollment Api Key: $(cat fleet_enrollment_api_key)"

