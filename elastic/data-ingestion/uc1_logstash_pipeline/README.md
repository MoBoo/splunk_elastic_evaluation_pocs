# Overview
This PoC uses Logstash as the main ingesting component.
Logstash uses diffrent input-methods to either receive data from remote clients such as beats or tcp, or read and forward local log files.

## Pipelines
There are 3 diffrent pipelines, which are used by Logstash:
- main
- access_combined_wcookie-processing
- test-processing

The pipelines are setup in a way that the main-pipeline forwards data to the other two pipelines based on some criteria.
The other two pipelines receive that from the main-pipeline, processes them and forwards them to a specific output.

The setup is also described in a blog post by elastic: https://www.elastic.co/blog/how-to-create-maintainable-and-reusable-logstash-pipelines
