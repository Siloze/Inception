#!/bin/bash
  if [ ! -f "/var/lib/mysql/tc.log" ]; then
    echo "[INSTALL] Installation des tables"
    # Creation de la table
    mysql_install_db --basedir=/usr \
	    --datadir='/var/lib/mysql' \
	    --user=mysql \
	    --pid-file='/run/mysqld/mysqld.pid' \
	    --socket='/run/mysqld/mysqld.sock' --port=3306 \
	    --bind-address=* \
	    --skip-networking=0 > /dev/null 

    # Lancement du service
    echo "[SETUP] Configuration de la base de donnée... [SETUP]"
    service mysql start
    sleep 1
    # Creation de la base de donnee
    echo "[SETUP] Creation de la base de donnée..."
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    sleep 1

    # Creation des utilisateurs
    echo "[SETUP] Creation des utilisateurs..."
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_ADMIN_USER}\`@'%' IDENTIFIED BY '${SQL_ADMIN_PASSWORD}';"
    sleep 1

    # Reglages des permissions
    echo "[SETUP] Reglages des permissions..."
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO \`${SQL_ADMIN_USER}\`@'%' WITH GRANT OPTION"
    sleep 1

    # Modification de l'utilisateur root
    echo "[SETUP] Modification de l'utilisateur root..."
    mysql -e "DELETE FROM mysql.user WHERE user='root' AND host != 'localhost';"
    mysql -e "DELETE FROM mysql.user WHERE user='';"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    sleep 1

    # On actualise les privilèges
    echo "[SETUP] Actualisation des privilèges..."
    mysql -e "FLUSH PRIVILEGES;" -u root -p$SQL_ROOT_PASSWORD
    sleep 1

    # Redemarrage de mysql
    echo "[SETUP] Redemarrage de mysql..."
    mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
    sleep 1

    echo "[SETUP] Configuration de la base de donnée terminée. [SETUP]"
else
     echo "Base de donnée déjà existante."
fi


# Execution recommandé de mysql
echo "|---Démarage du service MYSQL---|"
exec mysqld_safe --basedir=/usr \
       	--datadir='/var/lib/mysql' \
       	--user=mysql \
       	--pid-file='/run/mysqld/mysqld.pid' \
       	--socket='/run/mysqld/mysqld.sock' \
       	--port=3306 --bind-address=* \
       	--skip-networking=0
