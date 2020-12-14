#!/usr/bin/env bash

/wait-for-it.sh -t 0 db:3306

case "$1" in
  webserver)
    airflow db init
    exec airflow webserver
    ;;
  scheduler)
    # Give the webserver time to run initdb.
    sleep 20
    exec airflow "$@"
    ;;
  worker|flower)
    sleep 20
    exec airflow celery "$@"
    ;;
  version)
    exec airflow "$@"
    ;;
  *)
    # The command is something like bash, not an airflow subcommand. Just run it in the right environment.
    exec "$@"
    ;;
esac
