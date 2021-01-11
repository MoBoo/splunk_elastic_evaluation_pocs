#!/bin/bash
echo ">>> Import kibana objects: "

for file in ./kibana_export/*; do
        echo ">>> Importing: $file"
	curl -X POST "localhost:5601/api/saved_objects/_import?overwrite=true" -H "kbn-xsrf: true" --form "file=@$file";echo
        sleep 1
done
