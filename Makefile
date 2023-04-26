MAKEFLAGS += --silent

# Variables
DATABASE = mariadb
WEBSITE = wordpress
DOCKER_COMPOSE = sudo docker compose
DOCKER_COMPOSE_FOLDER = srcs
FILES_FOLDER = $(HOME)/data

# Colors
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
MAGENTA=\033[0;35m
CYAN=\033[0;36m
RESET=\033[0m

# Animation
SPINNER = |/-\|

# Commands
build:
	echo "$(CYAN)---Creating data folders...---$(RESET)"
	mkdir -p $(FILES_FOLDER)
	echo "$(YELLOW)Creating $(DATABASE) folder...$(RESET)"
	mkdir $(FILES_FOLDER)/$(DATABASE)
	echo "$(GREEN)$(DATABASE) folder created successfully!$(RESET)"
	echo "$(YELLOW)Creating $(WEBSITE) folder...$(RESET)"
	mkdir $(FILES_FOLDER)/$(WEBSITE)
	echo "$(GREEN)$(WEBSITE) folder created successfully!$(RESET)"

start:
	if [ ! -d $(FILES_FOLDER)/$(DATABASE) ]; then make build; fi
	echo "$(CYAN)---Starting docker containers...---$(RESET)"
	cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) up --build

stop:
	echo "$(CYAN)---Stopping docker containers...---$(RESET)"
	cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) stop && \
	$(DOCKER_COMPOSE) down

clean:
	echo "$(CYAN)---Cleaning data folders...---$(RESET)"
	echo "$(YELLOW)Cleaning $(DATABASE) folder...$(RESET)"
	sudo rm -rf $(FILES_FOLDER)/$(DATABASE)/*
	echo "$(GREEN)$(DATABASE) folder cleaned successfully!$(RESET)"
	echo "$(YELLOW)Cleaning $(WEBSITE) folder...$(RESET)"
	sudo rm -rf $(FILES_FOLDER)/$(WEBSITE)/*
	echo "$(GREEN)$(WEBSITE) folder cleaned successfully!$(RESET)"

fclean:  clean
	echo "$(CYAN)---Removing data folders and volumes...---$(RESET)"
	sudo rm -rf $(FILES_FOLDER)
	echo "$(YELLOW)Removing $(DATABASE) volume...$(RESET)"
	sudo docker volume rm srcs_mariadb
	echo "$(GREEN)$(DATABASE) volume removed successfully!$(RESET)"
	echo "$(YELLOW)Removing $(WEBSITE) volume...$(RESET)"
	sudo docker volume rm srcs_wordpress
	echo "$(GREEN)$(WEBSITE) volume removed successfully!$(RESET)"

re:
	make stop
	make start
 
.PHONY: start stop clean fclean re

.DEFAULT_GOAL :=  start
