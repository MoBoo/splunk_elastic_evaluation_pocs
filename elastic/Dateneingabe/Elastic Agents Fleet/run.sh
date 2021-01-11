#!/bin/bash

source .env

# Start docker container
echo ">>> Starting docker environment."
docker-compose up --build -d elasticsearch kibana

# wait for elasticsearch to be available.
echo ">>> Waiting for elasticsearch to become available. This may take a while."
until $(curl --output /dev/null --silent --head --fail --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD "localhost:9200"); do
	echo -n "."
	sleep 5
done

echo ""

# wait for kibana to be available.
echo ">>> Waiting for kibana to become available. This may take a while."
until $(curl --output /dev/null --silent --head --fail --user $ELASTIC_USERNAME:$ELASTIC_PASSWORD "localhost:5601"); do
        echo -n "."
        sleep 5
done
echo ""

docker-compose up --build -d elastic-agent

if [ -d "./setup" ]; then
	echo ">>> Running setup scripts."
	for file in ./setup/*; do
		echo ">>> Running: $file"
		$file
		sleep 1
	done
fi

echo ">>> Setup completed. Start streaming docker logs. (Ctrl+C to exit.)"

docker-compose logs -f

echo ">>> Cleanung & exiting."

# Wait for user input before stopping use-case.
echo ">>> Stopping docker container."
docker-compose stop

echo ">>> Removing docker environment."
docker-compose down -v
rm -rf ./elasticsearch/data/*

echo ">>> See you soon."

