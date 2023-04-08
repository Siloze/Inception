#!/bin/bash
/etc/init.d/mysql start
ls /var/log/mysql/
touch toto.txt
echo salut a tous > toto.txt
cat toto.txt
cat /var/log/mysql/error.log
sleep 5

# Creation de la table
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Creation de l'utilisateur
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Donner tous les droit a un user
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Modification de l'utilisateur root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# On actualise les privilèges
mysql -e "FLUSH PRIVILEGES;"

# Redemarrage de mysql
#mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Execution recommandé de mysql
#exec mysqld_safe