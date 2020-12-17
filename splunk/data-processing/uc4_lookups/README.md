# Overview
This PoC uses the Splunk [Universalforwarder](https://www.splunk.com/en_us/download/universal-forwarder.html) as the main ingesting component.

![Overview](docs/overview.png)

In this PoC the Universalforwarder is used to monitor the `/usr/share/data/accesss.log`-file on the local filesystem and output the data to Splunk.
Splunk then stores the data in the `http_logs` index. During searching Splunk looks up additional data (in this case `http status code descriptions`) and adds them to each event, according to the events http status code.
This is done defining a lookup in the [transforms.conf](splunk/etc/apps/http_status_code_lookup_TA/default/transforms.conf)-file, which is then referenced in [props.conf](splunk/etc/apps/http_status_code_lookup_TA/default/props.conf).

# Usage
To run the PoC simply execute the `run.sh` script. It will start all the docker-container and apply runtime configuration, aswell as output log messages and cleanup after you exit.
## Configuration
Connectivity-configuration is handled in the [docker-compose.yml](docker-compose.yml).
Splunk configuration is applied using apps (see [apps](splunk/etc/apps)-directory).
Universalforwarder configuration is handled via the Forwarder-Management: Configuration is stored in apps in the [deployment-apps](splunk/etc/deployment-apps)-directory of splunk and is then automatically distributed to forwarder.
