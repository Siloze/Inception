#!/bin/bash

# auto_config.sh
# This script is used to auto configure wordpress

# On attend que la databse est bien demarrée
sleep 10

# Pour eviter une eventuelle erreur de PHP
if [ -d "/run/php" ]; then
	echo "/run/php exists."
else
	echo "/run/php does not exist."
	mkdir /run/php
fi

# Pour eviter de reconfigurer wordpress a chaque fois
FILE=/var/www/wordpress/wp-config.sh
if [ -f "$FILE" ]; then
	echo "$FILE exists."
else
	echo "$FILE does not exist."
	wp config create	--allow-root \
					--dbname=$SQL_DATABASE \
					--dbuser=$SQL_USER \
					--dbpass=$SQL_PASSWORD \
					--dbhost=mariadb:3306 --path='/var/www/wordpress'
fi
