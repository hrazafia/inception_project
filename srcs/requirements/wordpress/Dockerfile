FROM debian:11

RUN apt-get update && apt-get install -y php7.4 php7.4-fpm \
  php7.4-mysql php7.4-xml php7.4-gd php7.4-curl curl

COPY ./conf/php.ini /etc/php/7.4/fpm/php.ini
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php \
    && chown www-data:www-data /run/php

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

VOLUME ["/var/www/hrazafia.42.fr"]

EXPOSE 9000

WORKDIR /var/www/hrazafia.42.fr

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]
