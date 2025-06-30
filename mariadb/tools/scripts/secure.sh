#!/usr/bin/env bash
set -e

USER_PASSWORD="$(<"$MYSQL_PASSWORD_FILE")"
ROOT_PASSWORD="$(<"$MYSQL_ROOT_PASSWORD_FILE")"

mysql -uroot -p"${ROOT_PASSWORD}" <<EOSQL
    DROP USER IF EXISTS ''@'localhost', ''@'%';
    DROP USER IF EXISTS 'root'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db LIKE 'test\\_%';
    FLUSH PRIVILEGES;
EOSQL
