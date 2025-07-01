#!/usr/bin/env bash
set -e

ROOT_PASSWORD="$(<"$MYSQL_ROOT_PASSWORD_FILE")"

MYSQL_SOCKET=/var/run/mysqld/mysqld.sock

mysql --user=root --socket="$MYSQL_SOCKET" <<EOSQL
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
  DELETE FROM mysql.user WHERE User='';
  DROP DATABASE IF EXISTS test;
  DELETE FROM mysql.db WHERE Db='test\\_%';
  FLUSH PRIVILEGES;
EOSQL
