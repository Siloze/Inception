
FROM debian:buster

# On met à jour le container
RUN apt update -y
RUN apt upgrade -y

# On install wget pour Wordpress
RUN apt-get -y install wget

# On install vim
RUN apt install vim -y

# On install PHP
RUN apt install -y php7.3 \
			php-fpm \
			php-mysql \
			mariadb-client

# Installation du CLI pour configurer wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# On deplace le fichier de configuration de PHP
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# # Configuration du CLI
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Configuration de Wordpress
COPY tools/auto_config.sh /tmp/auto_config.sh
ENTRYPOINT ["sh", "/tmp/auto_config.sh"]
