#!/bin/bash

# auto_config.sh
# This script is used to auto configure wordpress

# On attend que la databse est bien demarrée

START=$(date +%s)
#On télécharge Wordpress
if [ -f "/var/www/wordpress/index.php" ]; then
	echo "[INSTALL] Installation de Wordpress déjà existante."
else
	echo "[INSTALL] Téléchargement de Wordpress..."
	wget https://fr.wordpress.org/wordpress-6.1.1-fr_FR.tar.gz -P /var/www > /dev/null 2>&1 

	# On le décompresse et supprime le zip
	echo "[INSTALL] Décompression de l'archive..."
	cd /var/www && tar -xzf wordpress-6.1.1-fr_FR.tar.gz && rm wordpress-6.1.1-fr_FR.tar.gz > /dev/null 2>&1

	# On ajoute les droits
	echo "[INSTALL] Modification des droits d'accès..."
	chown -R root:root /var/www/wordpress

	echo "[INSTALL] Installation de Wordpress terminée."

fi

END=$(date +%s)
DIFF=$(( $END - $START ))

if [ "$DIFF" -lt 15 ]; then
	sleep $((10 - $DIFF))
fi

# Pour eviter une eventuelle erreur de PHP
if [ ! -d "/run/php" ]; then
	mkdir /run/php
fi

# Pour eviter de reconfigurer wordpress a chaque fois
FILE=/var/www/wordpress/wp-config.php
if [ ! -f "$FILE" ]; then
	echo "[SETUP] Configuration de Wordpress..."
	wp config create	--allow-root \
											--dbname=$SQL_DATABASE \
											--dbuser=$SQL_USER \
											--dbpass=$SQL_PASSWORD \
											--dbhost=mariadb:3306 --path='/var/www/wordpress'
	# mv /tmp/wp-config.php /var/www/wordpress/wp-config.php
	wp core install --url=localhost --title="Wordpress" --admin_user=$SQL_ADMIN_USER --admin_password=$SQL_ADMIN_PASSWORD --admin_email=$SQL_ADMIN_EMAIL --skip-email --allow-root --path='/var/www/wordpress'
fi

# Demarrage de PHP
echo "---Démarrage du service Wordpress.---"
/usr/sbin/php-fpm7.3 -F
