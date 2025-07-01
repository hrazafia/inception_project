#!/bin/bash
set -e

if [ ! -f /var/www/html/wp-config.php ]; then
  wp core download --allow-root

  wp config create --dbname="$WORDPRESS_DB_NAME" \
                   --dbuser="$WORDPRESS_DB_USER" \
                   --dbpass="$WORDPRESS_DB_PASSWORD" \
                   --dbhost="$WORDPRESS_DB_HOST" \
                   --allow-root

  wp core install --url="$WORDPRESS_URL" \
                  --title="$WORDPRESS_TITLE" \
                  --admin_user="$WORDPRESS_ADMIN_USER" \
                  --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
                  --admin_email="$WORDPRESS_ADMIN_EMAIL" \
                  --skip-email \
                  --allow-root

  wp user create 		${WP_USER} ${WP_USER_EMAIL} \
						--user_pass=${WP_USER_PASSWORD} \
						--role=author \
						--allow-root
fi

exec "$@"
