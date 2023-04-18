FROM debian:buster

RUN apt update -y ; \
    apt upgrade -y

RUN apt-get install mariadb-server -y

COPY ./tools/run.sh /tmp/run.sh

#ENTRYPOINT ["tail", "-f", "/dev/null"]
COPY ./tools/wordpress.sql /tmp/wordpress.sql
ENTRYPOINT ["sh", "/tmp/run.sh"]
