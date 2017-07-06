# Logstash Buildpack #
Logstash buildpack for appications built around or with logstash processes involved.

---
### Usage ###
This buildpack picks up settings through your application's environment variables.  The following are currently available for use.
* LOGSTASH_VERSION

   will default to the latest version (currently 5.4.0) if not specified
* LOGSTASH_METRICS_PORT

   will default to 9600-9700

* LOGSTASH_PLUGINS

   not required, specify in the following format `[\"plugin-one\", \"plugin-2\", \"plugin-3\"]`
   note: the quote escapes are a must, otherwise the function will break

#### Procfile Usage ####
This buildpack ensures logstash is on the application's PATH, so using it is as simple as..
```bash
first-logstash-process: logstash -f <path_to_logstash_file>
```
