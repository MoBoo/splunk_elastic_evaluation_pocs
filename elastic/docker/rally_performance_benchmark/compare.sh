#!/bin/bash

rm -rf rally/benchmarks/races/*

for file in ./benchmark_settings.d/*; do
        echo ">>> Running benchmark with track-params: $file"
	echo ">>> Settings"
	cat $file | jq .
	cp $file rally/track-params.json
        ./run.sh
        sleep 1
	echo ">>> Finished benchmark."
done

echo "Bye. :)"
