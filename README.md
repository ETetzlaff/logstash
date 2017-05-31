# Logstash Buildpack #
Logstash buildpack for appications built around or with logstash processes involved.

---
### Usage ###
This buildpack picks up settings through your application's environment variables.  The following are currently available for use.
* LOGSTASH_VERSION

   will default to the latest version (currently 5.4.0) if not specified
* LOGSTASH_METRICS_PORT

   will default to 9600-9700
