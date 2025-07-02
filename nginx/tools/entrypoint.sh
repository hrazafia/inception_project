#!/usr/bin/env sh
set -e

KEY_FILE=/etc/ssl/hrazafia.42.fr/hrazafia.42.fr.key
CRT_FILE=/etc/ssl/hrazafia.42.fr/hrazafia.42.fr.crt

mkdir -p "/etc/ssl/hrazafia.42.fr"

if [ ! -f "$KEY_FILE" ] || [ ! -f "$CRT_FILE" ]; then
  openssl req -newkey rsa:2048 -nodes -keyout "$KEY_FILE" \
    -x509 -days 365 -out "$CRT_FILE" \
    -subj "/C=MG/ST=Malagasy/L=Antananarivo/CN=hrazafia.42.fr"
fi

exec "$@"
