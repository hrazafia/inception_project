FROM debian:11

LABEL maintainer="hrazafia <hrazafia@student.42antananarivo.mg>"

RUN apt-get -y update && apt-get -y install mariadb-server mariadb-client

RUN mkdir -p /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

VOLUME ["/var/lib/mysql"]

COPY ./conf/my.cnf /etc/mysql/my.cnf

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x 

COPY ./tools/scripts/init.sh /usr/local/bin/scripts/init.sh
COPY ./tools/scripts/secure.sh /usr/local/bin/scripts/secure.sh

RUN chmod +x /usr/local/bin/entrypoint.sh \
  /usr/local/bin/scripts/init.sh /usr/local/bin/srcipts/secure.sh

EXPOSE 3306

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
  CMD bash -c "mysqladmin ping --silent -uroot -p\$(</run/secrets/db_root_password) || exit 1"

ENTRYPOINT ["entrypoint.sh"]
CMD ["mysqld", "--user=mysql"]
