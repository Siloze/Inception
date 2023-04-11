#!/bin/bash

# auto_config.sh
# This script is used to auto configure wordpress

# On attend que la databse est bien demarrée

#On télécharge Wordpress
if [ -f "/var/www/wordpress/index.php" ]; then
	echo "Installation de Wordpress déjà existante."
else
	echo "Installation de Wordpress..."
	wget https://fr.wordpress.org/wordpress-6.1.1-fr_FR.tar.gz -P /var/www > /dev/null 2>&1 
	# On le décompresse et supprime le zip
	cd /var/www && tar -xzf wordpress-6.1.1-fr_FR.tar.gz && rm wordpress-6.1.1-fr_FR.tar.gz > /dev/null 2>&1
	# On ajoute les droits
	chown -R root:root /var/www/wordpress
	echo "Installation de Wordpress terminée."
fi

sleep 10

# Pour eviter une eventuelle erreur de PHP
if [ ! -d "/run/php" ]; then
	mkdir /run/php
fi

cd /var/www/wordpress
# Pour eviter de reconfigurer wordpress a chaque fois
FILE=/var/www/wordpress/wp-config.php
if [ ! -f "$FILE" ]; then
	echo "Configuration de wordpress..."
	mv /tmp/wp-config.php /var/www/wordpress/wp-config.php
	echo "Configuration de wordpress terminée."
fi

# Demarrage de PHP
echo "Démarrage de PHP..."
/usr/sbin/php-fpm7.3 -F > /dev/null 2>&1 &
echo "PHP démarré."
