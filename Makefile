# Variables
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FOLDER = srcs
DATABASE_FOLDER = $(HOME)/Desktop/Inception/mariadb
# Commandes

start:
	@cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) up --build

stop:
	@cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) down

clean:
	@cd $(DATABASE_FOLDER) && \
	rm -rf ./*

.PHONY: start stop

# Par défaut, lancer la commande up
.DEFAULT_GOAL := start
