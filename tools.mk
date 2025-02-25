
all:

define createDir
	@printf "\n$(LF)🚧  $(P_BLUE)Creating directory $(P_YELLOW)$(1) $(FG_TEXT)"; \
	if [ -d "$(1)" ]; then \
		printf "$(LF)  🟢 $(P_BLUE)Directory $(P_YELLOW)$(1) $(P_BLUE)already exists \n"; \
	else \
		mkdir -p $(1); \
		chmod u+rwx $(1); \
		printf "$(LF)  🟢  $(P_BLUE)Successfully created directory $(P_GREEN)$(1) $(P_BLUE)! \n"; \
	fi
endef

show:
	@printf "$(LF)$(D_PURPLE)* List of all running containers$(P_NC)\n"
	@docker container ls

showAll:
	@printf "$(LF)$(D_PURPLE)* List all running and sleeping containers$(P_NC)\n"
	@docker container ls -a
	@printf "$(LF)$(D_PURPLE)* List all images$(P_NC)\n"
	@docker image ls
	@printf "$(LF)$(D_PURPLE)* List all volumes$(P_NC)\n"
	@docker volume ls
	@printf "$(LF)$(D_PURPLE)* List all networks$(P_NC)\n"
	@docker network ls

# ------------ GIT UTILS ------------
gAdd:
	@echo $(CYAN) && git add .
gCommit:
	@echo $(GREEN) && git commit -e ; \
	ret=$$?; \
	if [ $$ret -ne 0 ]; then \
		echo $(RED) "Error in commit message"; \
		exit 1; \
	fi
gPush:
	@echo $(YELLOW) && git push ; \
	ret=$$? ; \
	if [ $$ret -ne 0 ]; then \
		echo $(RED) "git push failed, setting upstream branch" $(YELLOW) && \
		git push --set-upstream origin $(shell git branch --show-current) || \
		if [ $$? -ne 0 ]; then \
			echo $(RED) "git push --set-upstream failed with error" $(E_NC); \
			exit 1; \
		fi \
	fi
git: gAdd gCommit gPush

# --------------------------------------#
encrypt:
	@rm -f .tmp.enc .tmp.tar.gz
	@tar -czf .tmp.tar.gz secrets/
	@bash -c ' \
	read -sp "Please enter some input: " user_input; \
	echo; \
	gpg --batch --passphrase "$$user_input" --symmetric --cipher-algo AES256 -o .tmp.enc .tmp.tar.gz '
	@rm .tmp.tar.gz

watch:
	@watch -n 1 ls -la $(VOLUMES)

list:
	@find services/ -type d -name '*-service'
	@ls -Rla $(VOLUMES)

id:
	cat /etc/subuid | grep $(USER)
	cat /etc/subgid | grep $(USER)
	id -u; id -g
	cat ~/.config/docker/daemon.json

alpine:
	@docker run --name temp-alpine alpine:latest sleep 1
	@docker commit --change "LABEL keep=true" temp-alpine alpine:latest-labeled
	@docker rm temp-alpine
cert:
	$(call createDir,$(SSL))
	@HOST=$(shell hostname -s) ; \
	if [ -f $(SSL)/$$HOST.key ] && [ -f $(SSL)/$$HOST.crt ]; then \
		printf "$(LF)  🟢 $(P_BLUE)Certificates already exists $(P_NC)\n"; \
	else \
		rm -rf $(SSL)/*; \
		docker run --rm --hostname pong.42wolfsburg.de -v $(SSL):/certs -it alpine:latest sh -c 'apk add --no-cache nss-tools curl ca-certificates && curl -JLO "https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64" && mv mkcert-v1.4.4-linux-amd64 /usr/local/bin/mkcert && chmod +x /usr/local/bin/mkcert && mkcert -install && mkcert -key-file /certs/$(shell hostname -s).key -cert-file /certs/$(shell hostname -s).crt $(shell hostname) && cp /root/.local/share/mkcert/rootCA.pem /certs/$(shell hostname -s).pem' ; \
	fi
# docker rm alpine
testCert:
	@openssl x509 -in $(SSL)/*.crt -text -noout
# docker run --rm -v /sgoinfre/$USER/data:/certs -it debian:bullseye sh -c 'apt-get update && apt-get install -y libnss3-tools curl && curl -JLO "https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64" && mv mkcert-v1.4.4-linux-amd64 /usr/local/bin/mkcert && chmod +x /usr/local/bin/mkcert && mkcert -install && mkcert -key-file /certs/privkey.key -cert-file /certs/fullchain.crt ${USER}.pong.42.fr'
#	@mkcert -key-file secrets/$(arg)/privkey.key -cert-file secrets/$(arg)/fullchain.crt ${USER}.pong.42.fr

members:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" -H "Accept: application/vnd.github+json"	 https://api.github.com/orgs/FT-Transcendence-February-2025/members | jq -r '.[].login' | paste -sd ' ' -

	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/orgs/FT-Transcendence-February-2025/teams | jq '.[].members_url'
	@logins=$$(curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/organizations/198072106/team/12155372/members | jq -r '.[].login' | paste -sd ' ' -); \
	ids=$$(curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/organizations/198072106/team/12155372/members | jq -r '.[].id' | paste -sd ' ' -); \
	echo "login: $$logins"; \
	echo "id: $$ids"

teams:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/orgs/FT-Transcendence-February-2025/teams | jq

microTeam:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/organizations/198072106/team/12155372/members | jq

gitRepoInfo:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/orgs/FT-Transcendence-February-2025 | jq

labels:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github.v3+json" \
	https://api.github.com/repos/FT-Transcendence-February-2025/FT_Transcendence/labels | \
	jq '.[].name'

user:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" -H "Accept: application/vnd.github+json" https://api.github.com/user | jq -r '.login'

email:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" -H "Accept: application/vnd.github+json" \
	https://api.github.com/user/emails | jq -r '.[] | select(.primary == true) | .email'

setGit:
	@USER_NAME=$$( $(MAKE) --no-print user | tr -d '"' ); \
	USER_EMAIL=$$( $(MAKE) --no-print email ); \
	git config --local user.name "$$USER_NAME"; \
	git config --local user.email "$$USER_EMAIL"

reposAdmin:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	`$(MAKE) --no-print reposApi` | jq -r '.[] | select(.permissions.admin == true) | .url'

microRepo:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	`$(MAKE) --no-print reposApi` | jq -r '.[] | select(.permissions.admin == true and (.url | tostring | contains("microservice"))) | .url'

microInfo:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	`$(MAKE) --no-print microRepo` | jq 

orgRepos:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/orgs/FT-Transcendence-February-2025/repos | jq
#| jq -r '.[].name'
reposApi:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/user/orgs | jq -r '.[].repos_url'

ownOrgsInfo:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	https://api.github.com/user/orgs | jq

info:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	`$(MAKE) --no-print ownOrgs` | jq

ssh_url:
	@curl -s -H "Authorization: token `cat $(TOKEN)`" \
	-H "Accept: application/vnd.github+json" \
	`$(MAKE) --no-print admin` | jq -r .ssh_url

issue:
	@chmod +x .settings/createIssue.sh
	@.settings/createIssue.sh
# issue:
# 	curl -s -H "Authorization: token `cat $(TOKEN)`" \
# 	-H "Accept: application/vnd.github+json" \
# 	-d '{
# 		  "title": "New Issue Title",
# 		  "body": "This is the body of the new issue.",
# 		  "assignees": ["username1", "username2"],
# 		  "labels": ["bug", "urgent"],
# 		  "milestone": 1,
# 		  "projects": ["project1"]
# 		}' \
# 	https://api.github.com/repos/FT-Transcendence-February-2025/microservices/issues 
#--------------------COLORS----------------------------#
# For print
CL_BOLD  = \e[1m
RAN	 	 = \033[48;5;237m\033[38;5;255m
D_PURPLE = \033[1;38;2;189;147;249m
D_WHITE  = \033[1;37m
NC	  	 = \033[m
P_RED	 = \e[1;91m
P_GREEN  = \e[1;32m
P_BLUE   = \e[0;36m
P_YELLOW = \e[1;33m
P_CCYN   = \e[0;1;36m
P_NC	 = \e[0m
LF	   = \e[1K\r$(P_NC)
FG_TEXT  = $(P_NC)\e[38;2;189;147;249m
# For bash echo
CLEAR  = "\033c"
BOLD   = "\033[1m"
CROSS  = "\033[8m"
E_NC   = "\033[m"
RED	= "\033[1;31m"
GREEN  = "\033[1;32m"
YELLOW = "\033[1;33m"
BLUE   = "\033[1;34m"
WHITE  = "\033[1;37m"
MAG	= "\033[1;35m"
CYAN   = "\033[0;1;36m"
GRAY   = "\033[1;90m"
PURPLE = "\033[1;38;2;189;147;249m"

define IMG

		⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
		⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢰⢲⠐⡖⡆⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
		⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⣸⣀⣇⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
		⣿⣿⣿⣿⣿⣿⣿⣿⠀⡤⡤⡤⣤⢠⡤⡤⡤⡄⢠⢤⡤⡤⡄⢸⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿
		⣿⣿⣿⣿⣿⣿⣿⣿⠀⡇⡇⡇⣿⢸⡇⡇⡇⡇⢸⢸⠀⡇⡇⢸⣿⣿⣿⣿⣿⣿⡟⢠⣦⡈⢿⣿⣿⣿⣿⣿⣿
		⣿⣿⣿⠉⣉⣉⣉⣉⠀⣉⣉⣉⣉⢈⣉⣉⣉⡁⢈⣉⣉⣉⡁⢈⣉⣉⣉⡉⣿⣿⠀⣿⣿⣿⡀⠿⠿⠿⢿⣿⣿
		⣿⣿⣿⠀⡇⡇⣿⢸⠀⡇⡇⡇⣿⢸⡇⡇⡇⡇⢸⢸⠉⡇⡇⢸⢸⢸⠁⡇⢸⣿⡄⢻⣿⣿⢣⣶⣶⣶⣦⠄⣹
		⡿⠻⠻⠀⠓⠓⠛⠚⠀⠓⠓⠓⠛⠘⠓⠓⠓⠃⠘⠚⠒⠓⠃⠘⠚⠚⠒⠃⠘⠛⢃⣠⣿⢣⣿⣿⡿⠟⢋⣴⣿
		⡇⢸⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣱⠃⣤⣤⣶⣾⣿⣿⣿
		⣷⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣽⠃⣰⣿⣿⣿⣿⣿⣿⣿
		⣿⡄⢻⣹⣿⣿⣿⣿⣿⣿⣿⣿⢫⠂⢯⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣫⡿⢁⣼⣿⣿⣿⣿⣿⣿⣿⣿
		⣿⣧⡈⢷⡻⣿⣿⣿⣿⣿⠟⣿⣯⣖⣮⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣫⡾⠋⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
		⣿⣿⣷⣄⠉⣉⣉⣉⣉⣤⣶⣎⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣵⠟⢋⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
		⣿⣿⣿⣿⣷⣌⠙⠿⣭⣟⣻⣿⢿⣯⡻⢿⣿⣿⣿⣿⣿⠿⠟⠛⣉⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
		⣿⣿⣿⣿⣿⣿⣿⣶⣦⣬⣉⣉⣛⣛⣛⣓⣈⣉⣉⣤⣤⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

endef
export IMG

define TRASH

		⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⣤⣤⣤⣄⡀⠀⠀⠀⠀⠀⠀
		⠀⠀⠀⠀⣰⣾⠋⠙⠛⣿⡟⠛⣿⣿⣿⣷⣆⠀⠀⠀⠀
		⠀⠀⢠⣾⣿⣿⣷⣶⣤⣀⡀⠐⠛⠿⢿⣿⣿⣷⡄⠀⠀
		⠀⢠⣿⣿⣿⡿⠿⠿⠿⠿⠿⠿⠶⠦⠤⢠⣿⣿⣿⡄⠀
		⠀⣾⣿⣿⣿⣿⠀⣤⡀⠀⣤⠀⠀⣤⠀⢸⣿⣿⣿⣷⠀
		⠀⣿⣿⣿⣿⣿⠀⢿⡇⠀⣿⠀⢠⣿⠀⣿⣿⣿⣿⣿⠀
		⠀⢿⣿⣿⣿⣿⡄⢸⡇⠀⣿⠀⢸⡏⠀⣿⣿⣿⣿⡿⠀
		⠀⠘⣿⣿⣿⣿⡇⢸⡇⠀⣿⠀⢸⡇⢠⣿⣿⣿⣿⠃⠀
		⠀⠀⠘⢿⣿⣿⡇⢸⣧⠀⣿⠀⣼⡇⢸⣿⣿⡿⠁⠀⠀
		⠀⠀⠀⠀⠻⢿⣷⡘⠛⠀⠛⠀⠸⢃⣼⡿⠟⠀⠀⠀⠀
		⠀⠀⠀⠀⠀⠀⠈⠙⠛⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀⠀
endef
export TRASH

define MANUAL

Example:
$(D_WHITE)[test]
$(D_PURPLE)$> make D=0 test
$(D_WHITE)[test + DEBUG]
$(D_PURPLE)$> make D=1 test
$(D_WHITE)[DEBUG + Valgrind]
$(D_PURPLE)$> make D=1 S=0 re val
$(D_WHITE)[DEBUG + Sanitizer]
$(D_PURPLE)$> make D=1 S=1 re test

endef
export MANUAL
