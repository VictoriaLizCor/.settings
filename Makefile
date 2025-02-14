#------ SRC FILES & DIRECTORIES ------#
SRCS	:= services
D		:= 0
CMD		:= docker compose
PROJECT_ROOT:= $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../)
GIT_REPO	:=$(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../..)
CURRENT		:= $(shell basename $$PWD)
DOCKER_DATA := '{"data-root": "/sgoinfre/$(USER)/docker/"}'
VOLUMES		:= /sgoinfre/$(USER)/data

SSL			:= ./secrets/nginx/ssl
export TOKEN=$(shell grep '^TOKEN' secrets/.env.tmp | cut -d '=' -f2 | xargs)
# WP_VOL		:= $(VOLUMES)/wordpress
# DB_VOL		:= $(VOLUMES)/mariadb
# MDB			:= $(SRCS)/requirements/mariadb
# WP			:= $(SRCS)/requirements/wordpress
SERVICES	:= $(shell docker compose config --services | xargs -I {} mkdir -p $(VOLUMES)/{})
NAME		:= ft_transcendence

-include tools.mk network.mk

#-------------------- RULES -------------------------#

all: buildAll up showAll

buildAll: volumes secrets
	@printf "\n$(LF)⚙️  $(P_BLUE) Building Images \n\n$(P_NC)";
ifneq ($(D), 0)
	@bash -c 'set -o pipefail; $(CMD) build --no-cache 2>&1 | tee build.log || { echo "Error: Docker compose build failed. Check build.log for details."; exit 1; }'
else
	@bash -c 'set -o pipefail; $(CMD) build --no-cache || { echo "Error: Docker compose build failed. Check build.log for details."; exit 1; }'
endif
	@printf "\n$(LF)🐳 $(P_BLUE)Successfully Builted Images! 🐳\n$(P_NC)"

# make dcon c=nginx
dcon: secrets
ifeq ($(D), 1)
	-@bash -c 'set -o pipefail; $(CMD) up $$c --build -d 2>&1 | tee up.log || { echo "Error: Docker compose up failed. Check up.log for details."; exit 1; }'
else
	@bash -c 'set -o pipefail; $(CMD) up $$c --build || { echo "Error: Docker compose up failed. Check up.log for details."; exit 1; }'
endif
	@$(MAKE) --no-print showAll logs

down:
	@printf "$(LF)\n$(P_RED)[-] Phase of stopping and deleting containers $(P_NC)\n"
	-@$(CMD) down -v --rmi local 

up:
	@printf "$(LF)\n$(D_PURPLE)[+] Phase of creating containers $(P_NC)\n"
	@$(CMD) up -d 

stop:
	@printf "$(LF)$(P_RED)  ❗  Stopping $(P_YELLOW)Containers $(P_NC)\n"
	@if [ -n "$$(docker ps -q)" ]; then \
		$(CMD) stop ;\
	fi

prune:
	@docker image prune -af > /dev/null
	@docker builder prune -af > /dev/null
	@docker system prune -af > /dev/null
	@docker volume prune -af > /dev/null

clean:
	@printf "\n$(LF)🧹 $(P_RED) Clean $(P_GREEN) $(CURRENT)\n"
	@printf "$(LF)\n  $(P_RED)❗  Removing $(FG_TEXT)"
	@$(MAKE) --no-print stop down
	@rm -rf *.log

fclean: clean remove_containers remove_images remove_volumes prune remove_networks rm-secrets
	-@if [ -d "$(VOLUMES)" ]; then	\
		printf "\n$(LF)🧹 $(P_RED) Clean $(P_YELLOW)Volume's Volume files$(P_NC)\n"; \
	fi
	@printf "$(LF)"
	@echo $(WHITE) "$$TRASH" $(E_NC)


rm-secrets: #clean_host
# -@if [ -d "./secrets" ]; then	\
# 	printf "$(LF)  $(P_RED)❗  Removing $(P_YELLOW)Secrets files$(FG_TEXT)"; \
# 	find ./secrets -type f -exec shred -u {} \;; \
# fi
	-@if [ -f ".env" ]; then \
		shred -u .env; \
	fi

secrets: #check_host
	@$(call createDir,./secrets)
# 	@chmod +x generateSecrets.sh
# 	@echo $(WHITE)
# 	@export $(shell grep '^TMP' srcs/.env.tmp | xargs) && \#
	@bash generateSecrets.sh $(D)
# 	@bash generateSecrets.sh
# 	@echo $(E_NC) > /dev/null

logs:
	@docker compose config --services | xargs -I {} docker logs {}
	@hostname -i

re: fclean all

volumes: #check_os
	@printf "$(LF)\n$(P_BLUE)⚙️  Setting $(P_YELLOW)$(NAME)'s volumes$(FG_TEXT)\n"
	@systemctl --user status docker;
	$(call createDir,$(VOLUMES))
# @if cat ~/.config/docker/daemon.json | grep -q $(DOCKER_DATA); then \
# 	echo "\tDocker data-Root correct" ; \
# 	exit 0; \
# else \
# 	echo $(DOCKER_DATA) > ~/.config/docker/daemon.json; \
# 	systemctl --user stop docker ; \
# rsync -aqxP /goinfre/$(USER)/docker/ /goinfre/$(USER)/docker/ ; \
# 	systemctl --user start docker; \
# 	systemctl --user status docker; \
# fi
#	~/.config/docker/daemon.json
# $(call createDir,$(DB_VOL))
# 
.PHONY: all buildAll set build up down clean fclean status logs restart re showAll check_os rm-secrets remove_images remove_containers remove_volumes remove_networks prune showData secrets