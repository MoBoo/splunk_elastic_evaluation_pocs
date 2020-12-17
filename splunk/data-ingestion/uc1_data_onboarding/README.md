# Overview
This PoC uses the Splunk [Universalforwarder](https://www.splunk.com/en_us/download/universal-forwarder.html) as the main ingesting component.

![Overview](uc1_data_onboarding.png)

In this PoC the Universalforwarder is used to monitor the `/usr/share/data/accesss.log`-file on the local filesystem and output the data to Splunk.
Splunk then stores the data in the `http_logs` index. When searched, Splunk applies the `access_combined` sourcetype to extract fields.

# Usage
To run the PoC simply execute the `run.sh` script. It will start all the docker-container and apply runtime configuration, aswell as output log messages and cleanup after you exit.
## Configuration
Connectivity-configuration is handled in the [docker-compose.yml](docker-compose.yml).
Splunk configuration is applied using apps (see [apps](splunk/etc/apps)-directory).
Universalforwarder configuration is handled via the Forwarder-Management: Configuration is stored in apps in the [deployment-apps](splunk/etc/deployment-apps)-directory of splunk and is then automatically distributed to forwarder.
