GIT_REPO :=$(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)/
SETTINGS := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/..)/.settings/
include $(SETTINGS)/colors.mk
CURRENT_PATH := $(PWD)/
HOOKS := $(SETTINGS)gitHooks/

# check if .git is a folder(main repo) o file(submodule)
ifneq ($(shell test -f .settings && echo yes),)
SETTINGS-HOOKS := $(realpath $(shell cat .git | awk '{ print $2 }'))/hooks
endif

GIT-HOOKS := $(GIT_REPO).git/hooks

### Maybe use for branches
#@for subdir in $$(find $(DIRS) -type d -name "ex0*" | sort); do \
	echo "\t"$(GRAY) $$subdir $(E_NC); \
	done;
dirs:
	@echo $(shell pwd)
	@echo GIT_REPO: $(GREEN) $(GIT_REPO) $(E_NC)
	@echo SETTINGS: $(YELLOW) $(SETTINGS) $(E_NC)
	@echo Git-hooks: $(YELLOW) $(GIT-HOOKS) $(E_NC)
	@echo ROOT_CPP_MODULES: $(CYAN) $(ROOT_CPP_MODULES) $(E_NC)
	@echo DIRS: $(BOLD) $(DIRS) $(E_NC)

settings:
	@echo $(YELLOW) $(SETTINGS-HOOKS) $(E_NC)
	@echo $(YELLOW) $(SETTINGS-GIT-HOOKS) $(E_NC)
	@echo Git-hooks: $(CYAN) $(GIT-HOOKS) $(E_NC)
	@echo Git-repo: $(CYAN) $(GIT_REPO) $(E_NC)
	@echo $(RED) $$(cat .git | awk '{ print $$2 }') $(E_NC)

.gitconfig:
	@git config --local --list
show-commit-msg:
	cat $(shell git config --get commit.template)

commit-template:
	@git config --local commit.template $(HOOKS).gitmessage
	@echo "commit-msg hook installed."

pre-commit:
	@hooks=$(GIT-HOOKS); \
	if [ "$(CURRENT_PATH)" = "$(SETTINGS)" ]; then \
		hooks=$(SETTINGS-HOOKS); \
	fi; \
	echo Setting:$(PURPLE) $$hooks $(E_NC); \
	cp $(HOOKS)prepare-commit-msg $$hooks; \
	chmod +x $$hooks/prepare-commit-msg; \
	if [ $$? -ne 0 ]; then \
		echo $(RED)"Error: prepare-commit-msg hook not installed"$(E_NC); \
		exit 1; \
	fi; \
	echo $(GREEN)"prepare-commit-msg hook installed."$(E_NC)

commit-msg:
	@hooks=$(GIT-HOOKS); \
	if [ "$(CURRENT_PATH)" = "$(SETTINGS)" ]; then \
		hooks=$(SETTINGS-HOOKS); \
	fi; \
	echo Setting:$(PURPLE) $$hooks $(E_NC); \
	cp $(HOOKS)commit-msg $$hooks; \
	chmod +x $$hooks/commit-msg; \
	if [ $$? -ne 0 ]; then \
		echo $(RED)"Error: commit-msg hook not installed"$(E_NC); \
		exit 1; \
	fi; \
	echo $(GREEN)"commit-msg hook installed."$(E_NC)

post-merge:
	@hooks=$(GIT-HOOKS); \
	if [ "$(CURRENT_PATH)" = "$(SETTINGS)" ]; then \
		hooks=$(SETTINGS-HOOKS); \
	fi; \
	echo Setting:$(PURPLE) $$hooks $(E_NC); \
	cp $(HOOKS)post-merge $$hooks; \
	chmod +x $$hooks/post-merge; \
	if [ $$? -ne 0 ]; then \
		echo $(RED)"Error: post-merge hook not installed"$(E_NC); \
		exit 1; \
	fi; \
	echo $(GREEN)"post-merge hook installed."$(E_NC)

show-pwd:
	@echo PWD:$(YELLOW) $(CURRENT_PATH) $(E_NC)

set-hooks: show-pwd pre-commit commit-msg post-merge
#------------------------- submodules
fetch-settings:
	@git submodule update --remote
	@echo "Submodule updated to the latest commit."
update-settings: show-pwd
	@echo $(YELLOW) $$(git config --get remote.origin.url) $(E_NC)
	@if [ "$$(pwd)" != "$(SETTINGS)" ]; then \
		cd $(SETTINGS); \
	fi && \
	$(MAKE) . git

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
git-sub:
	@echo "Checking if submodule was modified..."
	@if [ -n "$$(git diff --submodule)" ]; then \
		$(MAKE) . update-settings; \
		SUBMODULE_COMMIT_MESSAGE=$$(git log -1 --pretty=%B); \
		echo "$$SUBMODULE_COMMIT_MESSAGE"; \
		cd - > /dev/null; \
	fi
git: show-pwd
	@$(MAKE) -C . gAdd gCommit; \
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