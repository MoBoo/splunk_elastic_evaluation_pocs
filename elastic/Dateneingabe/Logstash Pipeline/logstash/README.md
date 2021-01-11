# Logstash Configuration
Logstash uses pipelines to receive, process and forward data.

## Pipelines ([pipelines.yml](config/pipelines.yml))
pipelines.yml defines the diffrent pipelines which are used by logstash, and where to find the configuration for each pipeline.
```
- pipeline.id: main
  path.config: "pipeline/pipelines.d/main/{01_input,01_filter,01_output}.cfg"

- pipeline.id: test-processing
  path.config: "pipeline/pipelines.d/test-processing/{01_input,01_filter,01_output}.cfg" 

- pipeline.id: access_combined_wcookie-processing
  path.config: "pipeline/pipelines.d/access_combined_wcookie-processing/{01_input,01_filter,01_output}.cfg"
```
### [main](pipeline/pipelines.d/main)
The `main`-pipeline is primary used as the main-input for logstash and defines 3 [inputs](pipeline/pipelines.d/main/01_input.cfg).
- [tcp](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-tcp.html) on port 5000
- [beats](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-beats.html) on port 5044
- [file](https://www.elastic.co/guide/en/logstash/current/plugins-inputs-file.html) on file `/usr/share/data/access.log`

In the [outputs](pipeline/pipelines.d/main/01_output.cfg) data is forwarded to either the `access_combined_wcookie-processing`- or `test-processing`-pipeline, based on which `tags` are set for each input.

### [access_combined_wcookie-processing](pipeline/pipelines.d/access_combined_wcookie-processing)
The `access_combined_wcookie-processing`-pipeline [receives data](pipeline/pipelines.d/access_combined_wcookie-processing/01_input.cfg) from the `main`-pipeline and processes it using a [grok](https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html)-[filter](pipeline/pipelines.d/access_combined_wcookie-processing/01_filter.cfg)
After processing the processed data is send to elasticsearch via the [elasticsearch](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-elasticsearch.html)-[output](pipeline/pipelines.d/access_combined_wcookie-processing/01_output.cfg)-plugin

### [test-processing](pipeline/pipelines.d/test-processing)
The `test-processing`-pipeline [receives data](pipeline/pipelines.d/test-processing/01_input.cfg) from the `main`-pipeline and outputs in to stdout using the [stdout](https://www.elastic.co/guide/en/logstash/current/plugins-outputs-stdout.html)-[output](pipeline/pipelines.d/test-processing/01_output.cfg)-plugin
