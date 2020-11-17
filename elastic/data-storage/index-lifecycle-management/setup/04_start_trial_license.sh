echo ">>> Start trial license"
/usr/bin/curl -H "Content-Type: application/json" -X POST "localhost:9200/_license/start_trial?acknowledge=true&pretty"
