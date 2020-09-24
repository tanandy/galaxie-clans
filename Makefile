help:
	@echo "`tput bold``tput smul`Galaxie Clans Ansible Toolkit`tput rmul``tput sgr0` v0.1"
	@echo ""
	@echo "`tput bold`INSTALLATION`tput sgr0`"
	@echo "	make sys-requirements  -- Install system requirements"
	@echo "	make hook-bash         -- Add direnv hook to ~/.bashrc"
	@echo "	make requirements      -- Install workspace requirements"
	@echo "	make first-date        -- Do sys-requirements + hook-bash + requirements"
	@echo ""
	@echo "`tput bold`FIRST DATE TOGETHER?`tput sgr0`"
	@echo "	make first-date"
	@echo ""
	@echo "`tput bold`DAY-TO-DAY TOOLING`tput sgr0`"
	@echo "	make apply-role -e role=<role_name> -e to=<inventory scope>     -- Applies a role to an inventory scope"
	@echo ""


sys-requirements:
	sudo apt-get install python3 python3-venv direnv -y

hook-bash:
	direnv hook bash >> ~/.bashrc

dependencies:
	pip install -U -r requirements.txt --no-cache

requirements:
	direnv allow .
	direnv reload
	pip install -U -r requirements.txt --no-cache
	direnv reload

first-date: sys-requirements hook-bash requirements

apply-role:
	ansible-playbook playbooks/apply-single-role.yml -e role_name=${role} -e scope=${to}

refresh/mo:
	ansible-playbook playbooks/clan-refresh-alliance.yml -e with_clan=rtnp_org

refresh:
	ansible-playbook playbooks/clan-refresh-alliance.yml -e with_clan=${with}


update:
	@wget -O named.root https://www.internic.net/domain/named.root;\
	cat /tmp/named.root | grep "A " | tr -s ' ' | cut -d ' ' -f 4 > /tmp/@.tmp;\
	if [ $$(cat /tmp/@.tmp | grep -c ".") -eq 26 ]; then \
		echo "Update roles/fehcom-djbdnscurve6/templates/etc/dnscache/servers/@.j2";\
		cat /tmp/@.tmp > roles/fehcom-djbdnscurve6/templates/etc/dnscache/servers/@.j2;\
	fi
#	rm @.tmp named.root

test:
	PREV_DIR=$$PWD;\
	GLX_ROLES_DIR=$$(realpath $$(echo "$$PWD/roles"));\
	for ROLE in $$(find $$GLX_ROLES_DIR -mindepth 1 -maxdepth 1 -type d); do \
		ROLE_NAME=$$(basename $$ROLE);\
		echo "$$ROLE_NAME";\
		cd $$GLX_ROLES_DIR/$$ROLE_NAME;\
		echo "$$PWD";\
	done;\
	cd $$PREV_DIR

molecule_create_network:
	bash -c "cd molecule/utils/tf_mods/mod_network && terraform init -input=false && terraform apply -auto-approve"

molecule_destroy_network:
	bash -c "cd molecule/utils/tf_mods/mod_network && terraform destroy -force"