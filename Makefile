DOTFILES_IGNORE := .git .gitmodules
DOTFILES := $(filter-out $(DOTFILES_IGNORE), $(wildcard .??*))
UPDATE_SCRIPTS := $(wildcard ./etc/update/*.sh)

deploy: deploy-prezto deploy-dotfiles

deploy-prezto:
	git submodule update --init --recursive

deploy-dotfiles:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update:
	@$(foreach val, $(UPDATE_SCRIPTS), bash $(val);)
