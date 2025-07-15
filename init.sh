#!/bin/bash

mkdir -p secrets

echo "admin123" > ./secrets/admin_passwd.txt
echo "pass1234" > ./secrets/user_passwd.txt
echo "user1234" > ./secrets/db_passwd.txt
echo "root1245" > ./secrets/db_root_passwd.txt

cat > ./srcs/.env << EOL
DOMAINE_NAME=hrazafia.42.fr
WEBSITE_TITLE="Inception 42 - hrazafia"

# MYSQL SETUP
DATABASE_HOST=mariadb

MYSQL_USER=wp_user
MYSQL_DATABASE=wordpressdb

#WORDPRESS
ADMIN_USER=hrazafia
ADMIN_EMAIL=hrazafia@student.42antananarivo.mg

USER_NAME=foo
USER_EMAIL=foo@emailpro.com
EOL
