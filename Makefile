DEPLOY_SCRIPT := ./etc/deploy.sh
UPDATE_SCRIPT := ./etc/update.sh

deploy: update-prezto
	bash $(DEPLOY_SCRIPT)

update: update-prezto
	bash $(UPDATE_SCRIPT)

update-prezto: update-repo
	git submodule update --init --recursive

update-repo:
	git pull origin main
