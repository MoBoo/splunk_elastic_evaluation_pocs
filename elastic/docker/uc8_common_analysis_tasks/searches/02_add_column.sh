# Not possible. Every field has to be defined during index-time (schema-on-write). An alternative would be to use scripted_fields, but those can't be used in searches.
# (vgl. https://discuss.elastic.co/t/how-to-query-a-computed-value-from-a-document/97116)
# Can be done during ingest-time with filter-plugins in logstash or ingest nodes.
echo ">>> Skipped."
exit 0
