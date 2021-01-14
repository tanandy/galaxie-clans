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
	pip3 install -U -r requirements.txt --no-cache

requirements:
	direnv allow .
	direnv reload
	pip3 install -U -r requirements.txt --no-cache
	direnv reload

first-date: sys-requirements hook-bash requirements

apply-role:
	ansible-playbook playbooks/apply-single-role.yml -e role_name=${role} -e scope=${to}

refresh/mo:
	ansible-playbook playbooks/clan-refresh-alliance.yml -e with_clan=rtnp_org

refresh:
	ansible-playbook playbooks/clan-refresh-alliance.yml -e with_clan=${with}


mailserver_refresh:
	ansible-playbook playbooks/apply_single_role.yml -e role_name=mailserver -e scope=${CLAN_SCOPE}

sphinx:
	@ echo "BUILD DOCUMENTATIONS"
	pip3 install -r documentation/requirements.txt --no-cache-dir --quiet
	cd documentation &&\
	make html
