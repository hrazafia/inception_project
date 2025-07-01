FROM debian:11

RUN apt-get -y update && apt-get -y install mariadb-client \
	&& apt-get -y install inetutils-ping && apt-get -y install curl

CMD ["tail", "-f", "/dev/null"]
