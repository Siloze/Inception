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

# Spinner animation
SPINNER = |/-\|

# Commands
build:
	@echo "$(CYAN)Creating data folders...$(RESET)"
	@mkdir -p $(FILES_FOLDER)
	@mkdir $(FILES_FOLDER)/$(DATABASE)
	@mkdir $(FILES_FOLDER)/$(WEBSITE)
	@echo "$(GREEN)Data folders created successfully!$(RESET)"

start:
	@if [ ! -d $(FILES_FOLDER)/$(DATABASE) ]; then make build; fi
	@echo "$(CYAN)Starting docker containers...$(RESET)"
	@cd $(DOCKER_COMPOSE_FOLDER) && \
	printf "$(YELLOW)Loading... $(RESET)"
	@$(DOCKER_COMPOSE) up --build > /dev/null 2>&1 &
	@while [ ! -f $(DOCKER_COMPOSE_FOLDER)/wordpress/wp-config.php ]; do \
		sleep 0.1; printf "\b${SPINNER:0:1}"; SPINNER=${SPINNER:1}${SPINNER:0:1}; \
	done; printf "\b\b\b$(GREEN)Docker containers started successfully!$(RESET)\n"

stop:
	@echo "$(CYAN)Stopping docker containers...$(RESET)"
	@cd $(DOCKER_COMPOSE_FOLDER) && \
	$(DOCKER_COMPOSE) stop > /dev/null 2>&1 &
	@while [ -n "$(sudo docker ps -q)" ]; do \
		sleep 0.1; printf "\b${SPINNER:0:1}"; SPINNER=${SPINNER:1}${SPINNER:0:1}; \
	done; printf "\b\b\b$(GREEN)Docker containers stopped successfully!$(RESET)\n"
	@$(DOCKER_COMPOSE) down > /dev/null 2>&1

clean:
	@echo "$(CYAN)Cleaning data folders...$(RESET)"
	@sudo rm -rf $(FILES_FOLDER)/$(DATABASE)/*
	@sudo rm -rf $(FILES_FOLDER)/$(WEBSITE)/*
	@echo "$(GREEN)Data folders cleaned successfully!$(RESET)"

fclean:  clean
	@echo "$(CYAN)Removing data folders and volumes...$(RESET)"
	@sudo rm -rf $(FILES_FOLDER)
	@sudo docker volume rm srcs_mariadb > /dev/null 2>&1 &
	@while [ -n "$(sudo docker volume ls -qf dangling=true)" ]; do \
		sleep 0.1; printf "\b${SPINNER:0:1}"; SPINNER=${SPINNER:1}${SPINNER:0:1}; \
	done; printf "\b\b\b$(GREEN)Data volumes removed successfully!$(RESET)\n"

re:
	@make stop
	@make start
 
.PHONY: start stop clean fclean re

.DEFAULT_GOAL :=  start
