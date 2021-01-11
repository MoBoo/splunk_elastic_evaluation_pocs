# Overview
This PoC shows some (basic) search-functionality provided by Splunk, which is discussed by [Analyzing Log Analysis: An Empirical Study of User Log Mining](https://www.usenix.org/conference/lisa14/conference-program/presentation/alspaugh)
For this demo searches have been prepared to showcase how certain analysis-tasks are replicated using Splunk.
The following analysis-tasks have been prepared (source can be found in [savedsearches.conf](splunk/etc/apps/common_analysis_tasks_TA/default/savedsearches.conf)):
- filtering of events
  - filter_by_fields
  - filter_columns
- adding a column/field to each event using the `eval`-statement
- grouping events by shared fields and calucation metrics upon each group
  - aggregation_count_by_method
  - aggregation_count_by_multiple_fields
  - aggregation_methods_by_field
- renaming fields
  - rename_column
  
The queries can be found in the [savedsearches.conf](splunk/etc/apps/common_analysis_tasks_TA/default/savedsearches.conf) or in [Splunk](http://localhost:8000/en-GB/manager/launcher/saved/searches?app=common_analysis_tasks_TA): Search & Reporting > Reports

![Overview](docs/overview.png)

In this PoC the Universalforwarder is used to monitor the `/usr/share/data/accesss.log`-file on the local filesystem and output the data to Splunk.

# Usage
To run the PoC simply execute the `run.sh` script. It will start all the docker-container and apply runtime configuration, aswell as output log messages and cleanup after you exit.
## Configuration
Connectivity-configuration is handled in the [docker-compose.yml](docker-compose.yml).
Splunk configuration is applied using apps (see [apps](splunk/etc/apps)-directory).
Universalforwarder configuration is handled via the Forwarder-Management: Configuration is stored in apps in the [deployment-apps](splunk/etc/deployment-apps)-directory of splunk and is then automatically distributed to forwarder.
