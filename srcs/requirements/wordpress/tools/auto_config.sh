#!/bin/bash

# Pour eviter une eventuelle erreur de PHP
if [ ! -d "/run/php" ]; then
	mkdir /run/php
fi

#On télécharge Wordpress
if [ -f "/var/www/wordpress/index.php" ]; then
	echo "[INSTALL] Installation de Wordpress déjà existante."
else
	echo "[INSTALL] Téléchargement de Wordpress..."
	wget https://fr.wordpress.org/wordpress-6.1.1-fr_FR.tar.gz -P /var/www > /dev/null 2>&1 

	echo "[INSTALL] Décompression de l'archive..."
	cd /var/www && tar -xzf wordpress-6.1.1-fr_FR.tar.gz && rm wordpress-6.1.1-fr_FR.tar.gz > /dev/null 2>&1

	echo "[INSTALL] Modification des droits d'accès..."
	chown -R root:root /var/www/wordpress

	echo "[INSTALL] Installation de Wordpress terminée. [INSTALL]"
fi
# On attend que MariaDB soit prêt
sleep 15

# On vérifie si la base de données existe
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	echo "[SETUP] Configuration de Wordpress..."
	wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
						--dbhost=mariadb:3306 \
					    --path='/var/www/wordpress'
	wp core install		--url=localhost \
						--title="Wordpress" \
						--admin_user=$SQL_ADMIN_USER \
						--admin_password=$SQL_ADMIN_PASSWORD \
						--admin_email=$SQL_ADMIN_EMAIL \
						--skip-email \
						--allow-root \
						--path='/var/www/wordpress'
	wp user create	$SQL_USER $SQL_EMAIL \
					--user_pass=$SQL_PASSWORD \
	       			--allow-root \
					--path='/var/www/wordpress' \
					--url=localhost
fi

echo "|---Démarrage du service Wordpress.---|"
/usr/sbin/php-fpm7.3 -F
