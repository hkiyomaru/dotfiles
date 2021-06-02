DOTFILES_IGNORE := .git .gitmodules
DOTFILES := $(filter-out $(DOTFILES_IGNORE), $(wildcard .??*))
INIT_SCRIPTS := $(wildcard ./etc/init/*.sh)

deploy: deploy-prezto deploy-dotfiles

deploy-prezto:
	git submodule update --init --recursive

deploy-dotfiles:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update:
	@$(foreach val, $(INIT_SCRIPTS), bash $(val);)
