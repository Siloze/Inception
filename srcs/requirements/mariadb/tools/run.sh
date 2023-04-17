#!/bin/bash
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "[SETUP] Configuration de la base de donnée..."
    mysql_install_db \
    --user=mysql \
    --datadir=/var/lib/mysql  \
    --port=3306 \
    --socket=/run/mysqld/mysqld.sock \
    --bind_address=* > /dev/null 2>&1

    echo "[SETUP] Démarrage de mysql..."
    service mysql start

    # Creation de la table
    echo "[SETUP] Creation de la base donnée..."
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    sleep 1

    # Creation de l'utilisateur
    echo "[SETUP] Creation de l'utilisateur..."
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
    sleep 1

    # Donner tous les droit a un user
    echo "[SETUP] Modification des privilèges..."
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
    sleep 1

    # Modification de l'utilisateur root
    echo "[SETUP] Modification du mot de passe root..."
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    sleep 1

    # On actualise les privilèges
    echo "[SETUP] Actualisation des privilèges..."
    mysql -e "FLUSH PRIVILEGES;" -u root -p"$SQL_ROOT_PASSWORD"
    sleep 1

    # Redemarrage de mysql
    echo "[SETUP] Redemarrage de mysql..."
    mysqladmin --user=root --password=$SQL_ROOT_PASSWORD shutdown

    echo "[SETUP] Configuration de la base de donnée terminée."
else
    echo "[SETUP] Base de donnée déjà existante."
fi

sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

# Execution recommandé de mysql
echo "---Démarrage du service MariaDB---"
exec mysqld_safe
