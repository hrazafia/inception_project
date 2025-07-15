#!/bin/bash
set -e

MYSQL_SOCKET=/var/run/mysqld/mysqld.sock

if [ ! -f /var/lib/mysql/.initialized ]; then
  mysqld --user=mysql --skip-networking --socket=$MYSQL_SOCKET &
  child_pid="$!"

  trap 'kill "$child_pid"; wait "$child_pid"; exit 1' ERR TERM INT

  for i in {0..30}; do
    if mysqladmin ping --silent --socket=$MYSQL_SOCKET; then
      break
    fi
    sleep 1
  done

  /usr/local/bin/scripts/init.sh
  /usr/local/bin/scripts/secure.sh

  touch /var/lib/mysql/.initialized

  kill "$child_pid"
  wait "$child_pid"
else
  echo "$(date '+%F %k:%M:%S') $$ [INFO] Data base is already initialized"
fi

exec "$@"
