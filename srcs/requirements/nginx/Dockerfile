FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="hrazafia <hrazafia@student.42antananarivo.mg>"

RUN apt-get update && apt-get -y install nginx openssl curl \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /etc/ssl/hrazafia.42.fr /var/www/hrazafia.42.fr \
  && chown -R www-data:www-data /etc/ssl/hrazafia.42.fr /var/www/hrazafia.42.fr

RUN openssl req -newkey rsa:2048 -nodes -x509 -days 365 \
    -keyout /etc/ssl/hrazafia.42.fr/hrazafia.42.fr.key \
    -out /etc/ssl/hrazafia.42.fr/hrazafia.42.fr.crt \
    -subj "/C=MG/ST=Malagasy/L=Antananarivo/O=42/CN=hrazafia.42.fr"

RUN rm -f /etc/nginx/sites-enabled/default \
  && rm -f /etc/nginx/sites-available/default

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

HEALTHCHECK --interval=15s --timeout=5s --start-period=15s --retries=5 \
  CMD curl -kfsS https://localhost/health || exit 1

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
