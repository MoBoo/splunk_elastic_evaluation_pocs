# Not possible. Every field has to be defined during index-time (schema-on-write).
# Can be done during ingest-time with the 'rename' filter in logstash or ingest nodes, or by using field aliases.

echo ">>> Skipped."
exit 0
