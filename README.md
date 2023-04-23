# Inception
## **Description**
Inception est un projet de l'école 42 qui consiste à créer un petit site web en utilisant plusieurs conteneurs Docker. Ce projet permet de mettre en pratique les concepts de virtualisation, de conteneurisation et de déploiement d'applications web.

## **Architecture du projet**
Le projet Inception est composé de trois conteneurs Docker :

- nginx : le conteneur Docker pour le serveur web. Il est utilisé pour servir les pages web statiques et pour diriger les requêtes HTTP vers les conteneurs de l'application.
- mariadb : le conteneur Docker pour la base de données. Il est utilisé pour stocker les données de l'application.
- wordpress-phpfpm : le conteneur Docker pour l'application web. Il contient l'application WordPress qui est servie par le serveur web.

Ces trois conteneurs sont reliés entre eux à l'aide d'un fichier docker-compose.yml, qui décrit la configuration des différents conteneurs et les liens entre eux.

## **Utilisation**
Installez Docker et Docker Compose sur votre système.

Clonez le dépôt du projet sur votre machine.

- `make build` : Creer les dossiers pour stocker localement les fichiers wordpress et mariadb ($(HOME)/Desktop/data).
- `make start` : Lancer les services a l'aide de docker compose.
- `make stop` : Arreter les services et supprimer le network.
- `make clean` : Reinitialiser la base de donnée ainsi que le site wordpress.
- `make fclean` : Supprimer le dossier data ainsi que tous les volumes correspondant au services.

Accédez au site web en ouvrant votre navigateur et en entrant l'URL suivante :

https://localhost/

Configuration
Vous pouvez configurer le projet Inception en modifiant les fichiers suivants :

docker-compose.yml : ce fichier définit les services Docker et leur configuration.
nginx/nginx.conf : ce fichier définit la configuration NGINX pour le serveur web.
php-fpm/Dockerfile : ce fichier définit la configuration de l'image Docker pour PHP-FPM.
mariaDB/init.sql : ce fichier contient les instructions SQL pour créer la base de données et importer les données de test.

Auteurs
Ce projet a été réalisé par Siloze dans le cadre du projet Incpetion de l'école 42.
