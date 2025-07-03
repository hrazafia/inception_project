#!/bin/bash
set -e

if [ ! -f /var/www/hrazafia.42.fr/wp-config.php ]; then
  wp core download --allow-root

  wp config create --dbname="hrazafiadb" \
                   --dbuser="hrazafia" \
                   --dbpass="user1234" \
                   --dbhost="mariadb" \
                   --allow-root

  wp core install --url="hrazafia.42.fr" \
                  --title="Inception" \
                  --admin_user="superuser" \
                  --admin_password="user1234" \
                  --admin_email="superuser@gmail.com" \
                  --skip-email \
                  --allow-root

  wp user create 		simpleuser simpleuser@gmail.com \
						--user_pass=user1234 \
						--role=author \
						--allow-root
fi

exec "$@"
