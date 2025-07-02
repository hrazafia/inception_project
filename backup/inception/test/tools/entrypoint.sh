#!/usr/bin/env bash
set -e

USER_PASSWORD="$(<"$MYSQL_PASSWORD_FILE")"
ROOT_PASSWORD="$(<"$MYSQL_ROOT_PASSWORD_FILE")"

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
  mysql -uroot -p"${ROOT_PASSWORD}" <<EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${USER_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

  mysql -uroot -p"${ROOT_PASSWORD}" <<EOSQL
    DROP USER IF EXISTS ''@'localhost', ''@'%';
    DROP USER IF EXISTS 'root'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db LIKE 'test\\_%';
    FLUSH PRIVILEGES;
EOSQL
  touch /var/lib/mysql/.initialized
else
  echo "[INFO] Data base is already initialized"
fi

kill "$child_pid"
wait "$child_pid"

exec "$@"
