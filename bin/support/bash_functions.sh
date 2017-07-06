export_env_dir() {
  WHITELIST_REGEX=${2:-'^(LOGSTASH_VERSION|JAVA_HEAP_SIZE)$'}
  BLACKLIST_REGEX=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH)$'}
  if [ -d "$ENV_DIR" ]; then
    for e in $(ls $ENV_DIR); do
      echo "$e" | grep -E "$WHITELIST_REGEX" | grep -qvE "$BLACKLIST_REGEX" &&
      export "$e=$(cat $ENV_DIR/$e)"
      :
    done
  fi
}

indent() {
  sed -u 's/^/       /'
}

check_logstash_var() {
  echo "------> Checking for LOGSTASH_VERSION presence"
  if [ -z "$LOGSTASH_VERSION" ]; then
    echo "LOGSTASH_VERSION not found, defaulting to highest version" | indent
    LOGSTASH_VERSION="5.4.0"
  fi
}

edit_config_values() {
  edit_port_for_metrics
}

edit_port_for_metrics() {
  echo "------> Checking for Logstash Metrics Port"
  if [[ $LOGSTASH_METRICS_PORT =~ ^[0-9]*$ ]]; then
    echo "Found valid port, setting metrics port to: $LOGSTASH_METRICS_PORT" | indent
    echo "http.port: $LOGSTASH_METRICS_PORT" >> $LOGSTASH_DIR/config/logstash.yml
  else
    echo "Invalid format found" | indent
  fi
}

install_plugins() {
  echo "------> Checking and installing declared plugins"
  echo "Found plugins are.." | indent
  echo $LOGSTASH_PLUGINS
  if [ -z "$LOGSTASH_PLUGINS" ]; then
    echo "No Logstash plugins were found"
  else
    echo "Found plugins, installing.." | indent
    echo $LOGSTASH_PLUGINS | python -c $'import sys, json\nfor x in json.load(sys.stdin):\n  print x\n\n' | xargs $LOGSTASH_DIR/bin/logstash-plugin install
  fi
}
