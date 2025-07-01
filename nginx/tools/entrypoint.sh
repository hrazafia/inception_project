#!/usr/bin/env sh
set -e

CRT_FILE=/etc/ssl/certs/hrazafia.42.fr.crt
KEY_FILE=/etc/ssl/private/hrazafia.42.fr.key

openssl req -newkey rsa:2048 -nodes -keyout "$KEY_FILE" \
  -x509 -days 365 -out "$CRT_FILE" \
  -subj "/C=MG/ST=Malagasy/L=Antananarivo/CN=hrazafia.42.fr"

exec "$@"
