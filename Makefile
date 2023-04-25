# Variables
DATABASE = mariadb
WEBSITE = wordpress
DOCKER_COMPOSE = sudo docker compose
DOCKER_COMPOSE_FOLDER = srcs
FILES_FOLDER = $(HOME)/data
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
	$(DOCKER_COMPOSE) stop && \
	$(DOCKER_COMPOSE) down

clean:  
	sudo rm -rf $(FILES_FOLDER)/$(DATABASE)/*
	sudo rm -rf $(FILES_FOLDER)/$(WEBSITE)/*

fclean:  clean
	@sudo rm -rf $(FILES_FOLDER)
	@sudo docker volume rm srcs_mariadb
	@sudo docker volume rm srcs_wordpress

re:
	@make stop && \
	make start
 
.PHONY: start stop

.DEFAULT_GOAL :=  start
