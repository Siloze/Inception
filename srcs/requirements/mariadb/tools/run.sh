#!/bin/bash
#!/bin/bash
#  if [ ! -f "/var/lib/mysql/tc.log" ]; then
    echo "Configuration de la base de donnée..."

    #mysql_install_db --basedir=/usr --datadir='/var/lib/mysql' --user=mysql --pid-file='/run/mysqld/mysqld.pid' --socket='/run/mysqld/mysqld.sock' --port=3306 --bind-address=* --skip-networking=0

    service mysql start

    sleep 1
    # Creation de la table
    mysql -u root < /tmp/wordpress.sql
    echo "Creation de la base de donnée..."
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    sleep 1

    # Creation de l'utilisateur
    echo "Creation de l'utilisateur..."
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    sleep 1

    # Donner tous les droit a un user
    echo "Donner tous les droit a l'utilisateur..."
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    sleep 1

    # Modification de l'utilisateur root
    echo "Modification de l'utilisateur root..."
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    sleep 1

    # On actualise les privilèges
    echo "Actualisation des privilèges..."
    mysql -e "FLUSH PRIVILEGES;" -u root -p$SQL_ROOT_PASSWORD
    sleep 1

    # Redemarrage de mysql
    echo "Redemarrage de mysql..."
    mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
    sleep 1
    echo "Configuration de la base de donnée terminée."
# else
#      echo "Base de donnée déjà existante."
# fi


# Execution recommandé de mysql
#exec mysqld_safe
exec mysqld_safe --basedir=/usr --datadir='/var/lib/mysql' --user=mysql --pid-file='/run/mysqld/mysqld.pid' --socket='/run/mysqld/mysqld.sock' --port=3306 --bind-address=* --skip-networking=0