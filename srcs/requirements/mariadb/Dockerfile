FROM debian:buster

RUN apt update -y ; \
    apt upgrade -y ; \
    apt-get install mariadb-server -y;

COPY tools/run.sh /tmp/run.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
ENTRYPOINT ["sh", "/tmp/run.sh"]