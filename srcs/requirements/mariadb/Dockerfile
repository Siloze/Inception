FROM debian:buster

RUN apt update -y ; \
    apt upgrade -y ; \
    apt-get install mariadb-server -y

COPY ./tools/run.sh /tmp/run.sh

ENTRYPOINT ["sh", "/tmp/run.sh"]
