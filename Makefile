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
	@if [ ! -d $(FILES_FOLDER)/$(DATABASE) ]; then make build; fi
	@cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) up --build

stop:
	@cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) down

clean:  
	rm -rf $(FILES_FOLDER)/$(DATABASE)/*
	rm -rf $(FILES_FOLDER)/$(WEBSITE)/*

fclean:  clean
	@rm -rf $(FILES_FOLDER)
	@docker volume rm srcs_mariadb
	@docker volume rm srcs_wordpress

re:
	@make stop && \
	make start
 
.PHONY: start stop

.DEFAULT_GOAL :=  start
