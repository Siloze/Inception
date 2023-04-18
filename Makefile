# Variables
DATABASE = mariadb
WEBSITE = wordpress
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FOLDER = srcs
FILES_FOLDER = $(HOME)/Desktop/Inception
# Commandes

build: 
	mkdir -p $(FILES_FOLDER)
	mkdir $(FILES_FOLDER)/$(DATABASE)
	mkdir $(FILES_FOLDER)/$(WEBSITE)

start:
	@cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) up --build

stop:
	@cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) down

clean:  
	rm -rf $(FILES_FOLDER)/$(DATABASE)/* && \
	rm -rf $(FILES_FOLDER)/$(WEBSITE)/*

re:
	@make stop && \
	make start
 
.PHONY: start stop

# Par défaut, lancer la commande up
.DEFAULT_GOAL := start
