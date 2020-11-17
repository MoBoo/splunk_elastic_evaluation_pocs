
#!/bin/bash
# Start docker container
echo ">>> Starting docker environment."
docker-compose up --build -d splunk universalforwarder

# wait for splunk to become available.
echo ">>> Waiting for Splunk Web to become available. This may take a while."
until $(curl --output /dev/null --silent --head --fail "localhost:8000"); do
	echo -n "."
	sleep 5
done

echo "Setup completed. Start streaming docker logs. (Ctrl+C to exit.)"
docker-compose logs -f

echo ">>> Cleanung & exiting."

echo ">>> Stopping docker container."
docker-compose stop

echo ">>> Removing docker environment."
docker-compose down -v

echo "Attempting to reset to default permissions... (sudo required)"
sudo ../../scripts/reset_permissions.sh

echo ">>> See you soon."
