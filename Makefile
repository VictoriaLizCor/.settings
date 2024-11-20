GIT_REPO :=$(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)/
SETTINGS := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)/.settings/
include $(SETTINGS)/colors.mk
CURRENT_PATH := $(PWD)
HOOKS := $(SETTINGS)gitHooks/
SETTINGS-GIT-HOOKS := $(shell git config --file $(GIT_REPO).gitmodules --get-regexp path | awk '{ print $$2 }')
GIT-HOOKS := $(GIT_REPO).git/hooks/

dirs:
	@echo $(shell pwd)
	@echo GIT_REPO: $(GREEN) $(GIT_REPO) $(E_NC)
	@echo SETTINGS: $(YELLOW) $(SETTINGS) $(E_NC)
	@echo Git-hooks: $(YELLOW) $(GIT-HOOKS) $(E_NC)
	@echo ROOT_CPP_MODULES: $(CYAN) $(ROOT_CPP_MODULES) $(E_NC)
	@echo DIRS: $(BOLD) $(DIRS) $(E_NC)
	@for subdir in $$(find $(DIRS) -type d -name "ex0*" | sort); do \
		echo "\t"$(GRAY) $$subdir $(E_NC); \
	done;
.gitconfig:
	@git config --local --list
show-commit-msg:
	cat $(shell git config --get commit.template)

commit-template:
	@git config --local commit.template $(HOOKS).gitmessage
	@echo "commit-msg hook installed."

pre-commit:
	@echo $(CURRENT_PATH)
	@hooks=0; 
	@if [ "$$(pwd)" == "$(SETTINGS)" ]; then \
		hooks=$()
	@echo $(GIT-HOOKS)
	@cp $(HOOKS)prepare-commit-msg $(GIT-HOOKS)
	@chmod +x $(GIT-HOOKS)prepare-commit-msg
	@echo "prepare-commit-msg hook installed."

commit-msg:
	@cp $(HOOKS)commit-msg $(GIT-HOOKS)
	@chmod +x $(GIT-HOOKS)commit-msg
	@echo "commit-msg hook installed."

post-merge:
	@cp $(HOOKS)post-merge $(GIT-HOOKS)
	@chmod +x $(GIT-HOOKS)post-merge
	@echo "post-merge hook installed."

set-hooks: pre-commit commit-msg post-merge
#------------------------- submodules
settings:
	@echo $(YELLOW) $(SETTINGS-GIT-HOOKS) $(E_NC)
	@echo $(shell git config --file $(GIT_REPO).gitmodules --get-regexp path | awk '{ print $$2 }')
fetch-settings:
	@git submodule update --remote
	@echo "Submodule updated to the latest commit."
update-settings:dirs
	@echo $$pwd
	@echo $(YELLOW) $$(git config --get remote.origin.url) $(E_NC)
	@if [ "$$(pwd)" != "$(SETTINGS)" ]; then \
		cd $(SETTINGS) && pwd; \
	fi && \
	$(MAKE) -C . git

#@git add $(SETTINGS)

#-------------------------VS Code
.vscode:
	@cp -r $(SETTINGS).vscode .

gAdd:
	@echo $(CYAN) && git add .
gCommit:
	@echo $(GREEN) && git commit -e ; \
	ret=$$? ; \
	if [ $$ret -ne 0 ]; then \
		echo $(RED) "Error in commit message"; \
		exit 1; \
	fi
gPush:
	@echo $(YELLOW) && git push ; \
	ret=$$? ; \
	if [ $$ret -ne 0 ]; then \
		echo $(RED) "git push failed, setting upstream branch\n" $(YELLOW) && \
		git push --set-upstream origin $(shell git branch --show-current) || \
		if [ $$? -ne 0 ]; then \
			echo $(RED) "git push --set-upstream failed with error" $(E_NC); \
		fi \
	fi

git: gAdd
	@$(MAKE) -C . gCommit; \
	ret=$$?; \
	if [ $$ret -ne 0 ]; then \
		exit 1; \
	else \
		$(MAKE) -C . gPush; \
	fi

# quick: cleanAll
# 	@echo $(GREEN) && git commit -am "* Update in files: "; \
# 	ret=$$? ; \
# 	if [ $$ret -ne 0 ]; then \
# 		exit 1; \
# 	else \
# 		$(MAKE) -C . gPush; \
# 	fi

# # Avoid last commit message
# soft:
# 	@echo $(GREEN) "\nLast 10 commits:" $(E_NC)
# 	@$(MAKE) plog && echo 
# 	@read -p "Do you want to reset the last commit? (y/n) " yn; \
# 	case $$yn in \
# 		[Yy]* ) git reset --soft HEAD~1;\
# 		git push origin --force-with-lease $(shell git branch --show-current) ;\
# 		echo $(RED) "Last commit reset" $(E_NC) ;; \
# 		* ) echo $(MAG) "No changes made" $(E_NC) ;; \
# 	esac
# amend:
# 	@echo $(CYAN) && git commit --amend; \
# 	result=$$?; \
# 	if [ $$result -ne 0 ]; then \
# 		echo $(RED) "The amend commit message was not modified."; \
# 		exit 1; \
# 	else \
# 		echo $(YELLOW) && git push origin --force-with-lease $(shell git branch --show-current); \
# 		exit 0; \
# 	fi