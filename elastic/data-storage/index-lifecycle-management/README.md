# Scenario 1: Index-Rollover
Rollover current index (index_name-000001) to a new index (index_name-000002) when certain criteria is matched.
## In this example
- create a new index, once the current index age reaches 3 minutes OR index size reaches 50GB
- move the index to cold phase, 5 minutes after the rollover from hot phase
- delete the index, 10 minutes after the rollover.

## Implementation Overview
When an index is created, a ilm-policy is applied automatically (because of the index-template used).
The index-template also specifies a lifecycle.rollover-alias, which points to the current active index. This alias is used to query and write documents.
When a rollover happens, a new index is created with an incremented index_name (e.g. index_name-000001 -> rollover -> index_name-000002). Now index_name-000002 is the current active index, which will be used to write new data to. All other indexes are still in use for querying data.

To make use of index-lifecycle-management an elasticsearch-cluster is required, which has ilm-phases (hot, warm, cold) aware nodes.
(https://www.elastic.co/guide/en/elasticsearch/reference/current/example-using-index-lifecycle-policy.html)

# Scenario 2: Data Streams
Index-Rollover and Data Streams share the same idea. The diffrence is, that indexes become read-only after they are rolled over. Therefore it is not possible to insert new data, update or delete existing documents.

## In this example
- Rollover to a new index, every 1 minute, or whenever an index reaches 50GB in size.

# Configuration
See scripts in setup-directory.
- elasticsearch.yml: adjust `indices.lifecycle.poll_interval` to showcase ilm usage.
