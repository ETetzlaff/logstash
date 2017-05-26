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
