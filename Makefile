#------ SRC FILES & DIRECTORIES ------#
SRCS	:= srcs
D		:= 0
CMD		:= docker compose
PROJECT_ROOT:= $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../)
GIT_REPO	:=$(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../..)
CURRENT		:= $(shell basename $$PWD)
VOLUMES		:= /sgoinfre/$(USER)/data/
export TOKEN=$(shell grep '^TOKEN' secrets/.env.tmp | cut -d '=' -f2 | xargs)
# WP_VOL		:= $(VOLUMES)/wordpress
# DB_VOL		:= $(VOLUMES)/mariadb
# MDB			:= $(SRCS)/requirements/mariadb
# WP			:= $(SRCS)/requirements/wordpress
# NG			:= $(SRCS)/requirements/nginx
NAME		:= ft_transcendence

-include tools.mk network.mk

#-------------------- RULES -------------------------#

all: buildAll up showAll

buildAll: volumes secrets
	@printf "\n$(LF)⚙️  $(P_BLUE) Building Images \n\n$(P_NC)";
ifneq ($(D), 0)
	@bash -c 'set -o pipefail; $(CMD) build 2>&1 | tee build.log || { echo "Error: Docker compose build failed. Check build.log for details."; exit 1; }'
else
	@bash -c 'set -o pipefail; $(CMD) build || { echo "Error: Docker compose build failed. Check build.log for details."; exit 1; }'
endif
	@printf "\n$(LF)🐳 $(P_BLUE)Successfully Builted Images! 🐳\n$(P_NC)"


detach:
ifeq ($(D), 1)
	$(CMD) up --build -d
else
	$(CMD) up --build || true
endif


down:
	@printf "$(LF)\n$(P_RED)[-] Phase of stopping and deleting containers $(P_NC)\n"
	@$(CMD) down -v --rmi local 
#down --volumes

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
	@docker volume prune -f > /dev/null

clean:
	@printf "\n$(LF)🧹 $(P_RED) Clean $(P_GREEN) $(CURRENT)\n"
	@printf "$(LF)\n  $(P_RED)❗  Removing $(FG_TEXT)"
	@$(MAKE) --no-print stop down
	@rm -rf srcs/*.log

fclean: clean remove_containers remove_images remove_volumes prune remove_networks rm-secrets
	-@if [ -d "$(VOLUMES)" ]; then	\
		printf "\n$(LF)🧹 $(P_RED) Clean $(P_YELLOW)Volume's Volume files$(P_NC)\n"; \
	fi
	@printf "$(LF)"
	@echo $(WHITE) "$$TRASH" $(E_NC)


rm-secrets: clean_host
	-@if [ -d "./secrets" ]; then	\
		printf "$(LF)  $(P_RED)❗  Removing $(P_YELLOW)Secrets files$(FG_TEXT)"; \
		find ./secrets -type f -exec shred -u {} \;; \
	fi
	-@if [ -f "$(SRCS)/.env" ]; then \
		shred -u $(SRCS)/.env; \
	fi

secrets: check_host
	@$(call createDir,./secrets)
# 	@chmod +x generateSecrets.sh
# 	@echo $(WHITE)
# 	@export $(shell grep '^TMP' srcs/.env.tmp | xargs) && \
# 	bash generateSecrets.sh $$TMP #for testing
# 	@bash generateSecrets.sh
# 	@echo $(E_NC) > /dev/null

re: fclean all

volumes: #check_os
	@printf "$(LF)\n$(P_BLUE)⚙️  Setting $(P_YELLOW)$(NAME)'s volumes$(FG_TEXT)\n"
	$(call createDir,$(WP_VOL))
	$(call createDir,$(DB_VOL))

.PHONY: all buildAll set build up down clean fclean status logs restart re showAll check_os rm-secrets remove_images remove_containers remove_volumes remove_networks prune showData secrets check_host