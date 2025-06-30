#!/usr/bin/env bash
set -e

trap "kill $child_pid; wait $child_pid; exit 0" TERM INT

if [ ! -d /var/lib/mysql/mysql ]; then
  mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

mysqld --user=mysql --skip-networking --socket=/var/run/mysqld/mysqld.sock &
child_pid="$!"

for i in {30..0}; do
  if mysqladmin ping --silent --socket=/var/run/mysqld/mysqld.sock; then
    break
  fi
  sleep 1
done

if [ ! -f /var/lib/mysql/.initialized ]; then
  /usr/local/bin/scripts/init.sh
  /usr/local/bin/scripts/secure.sh

  touch /var/lib/mysql/.initialized
else
  echo "[INFO] Data base is already initialized"
fi

kill "$child_pid"
wait "$child_pid"

exec "$@"
