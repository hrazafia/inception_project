FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="hrazafia <hrazafia@student.42antananarivo.mg>"

RUN apt-get update && apt-get install -y php7.4 php7.4-fpm \
  php7.4-mysql php7.4-xml php7.4-gd php7.4-curl curl \
  && rm -rf /var/lib/apt/lists/*

COPY ./conf/php.ini /etc/php/7.4/fpm/php.ini
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php /var/www/hrazafia.42.fr \
  && chown -R www-data:www-data /run/php /var/www/hrazafia.42.fr

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/hrazafia.42.fr

RUN wp core download --allow-root

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=5 \
  CMD ["wp", "core", "is-installed", "--allow-root"]

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]
