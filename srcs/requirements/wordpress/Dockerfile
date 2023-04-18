
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

# # On télécharge Wordpress
# RUN wget https://fr.wordpress.org/wordpress-6.1.1-fr_FR.tar.gz -P /var/www
# # On le décompresse et supprime le zip
# RUN cd /var/www && tar -xzf wordpress-6.1.1-fr_FR.tar.gz && rm wordpress-6.1.1-fr_FR.tar.gz


# Installation du CLI pour configurer wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# On deplace le fichier de configuration de PHP
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# # Configuration du CLI
 RUN chmod +x wp-cli.phar
 RUN mv wp-cli.phar /usr/local/bin/wp

# Configuration de Wordpress
COPY conf/wp-config.php /tmp/wp-config.php
COPY tools/auto_config.sh /tmp/auto_config.sh
ENTRYPOINT ["sh", "/tmp/auto_config.sh"]

#ENTRYPOINT ["tail", "-f", "/dev/null"]


