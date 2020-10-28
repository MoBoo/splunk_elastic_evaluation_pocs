#!/bin/bash

# Start docker container
echo ">>> Starting docker environment."
docker-compose up --build -d elasticsearch

# wait for elasticsearch to be available.
echo ">>> Waiting for elasticsearch to become available. This may take a while."
until $(curl --output /dev/null --silent --head --fail "localhost:9200"); do
	echo -n "."
	sleep 5
done

echo ""

echo ">>> Starting Rally Benchmark"
docker run --rm --network=performance-benchmark_elastic -v $PWD/rally/:/rally/.rally elastic/rally --track=eventdata --pipeline=benchmark-only --target-hosts="elasticsearch:9200" --track-params="/rally/.rally/track-params.json"

echo ">>> Cleanung & exiting."

# Wait for user input before stopping use-case.
echo ">>> Stopping docker container."
docker-compose stop

echo ">>> Removing docker environment."
docker-compose down -v
rm -rf ./elasticsearch/data/*

echo ">>> See you soon."

