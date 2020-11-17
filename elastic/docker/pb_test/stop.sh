#!/bin/bash

echo ">>> Cleanung & exiting."

# Wait for user input before stopping use-case.
echo ">>> Stopping docker container."
docker-compose stop

echo ">>> Removing docker environment."
docker-compose down -v
rm -rf ./elasticsearch/data/*

echo ">>> See you soon."

