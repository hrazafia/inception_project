#!/usr/bin/env sh
set -e

CERT_DIR=/etc/ssl/hrazafia.42.fr
KEY_FILE=${CERT_DIR}/hrazafia.42.fr.key
CRT_FILE=${CERT_DIR}/hrazafia.42.fr.crt

# create dirs if missing
mkdir -p "$CERT_DIR"

# generate key+cert if not exists
if [ ! -f "$KEY_FILE" ] || [ ! -f "$CRT_FILE" ]; then
  echo "Generating self-signed certificate for hrazafia.42.fr..."
  openssl req -newkey rsa:2048 -nodes -keyout "$KEY_FILE" \
    -x509 -days 365 \
    -out "$CRT_FILE" \
    -subj "/C=FR/ST=Some-State/L=Some-City/O=MyOrg/CN=hrazafia.42.fr"
fi

exec "$@"
