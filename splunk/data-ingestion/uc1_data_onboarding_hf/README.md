Architecture
UF -----> HF -----> Splunk

UF: Reads /var/log/access.logs and forwards them to the HF.
HF: Receives logs from UF, processes them (removes JSESSIONID from event) and forwards them to Splunk. Also reads own /var/log/access.log messages and also processes and forwards them to Splunk.
Splunk: Receives data from HF and stores them.
