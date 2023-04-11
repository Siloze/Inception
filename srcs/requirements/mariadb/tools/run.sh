#!/bin/bash
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Configuration de la base de donnée..."
    mysql_install_db \
    --user=mysql \
    --datadir=/var/lib/mysql  \
    --port=3306 \
    --socket=/run/mysqld/mysqld.sock \
    --bind_address=* > /dev/null


    service mysql start > /dev/null 2>&1
    # Creation de la table
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

    # Creation de l'utilisateur
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

    # Donner tous les droit a un user
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

    # Modification de l'utilisateur root
    # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

    # # On actualise les privilèges
    # mysql -e "FLUSH PRIVILEGES;"

    # # Redemarrage de mysql
    # mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
    echo "Configuration de la base de donnée terminée."
else
    echo "Base de donnée déjà existante."
fi


# Execution recommandé de mysql
#exec mysqld_safe > /dev/null 2>&1
exec mysqld_safe 
