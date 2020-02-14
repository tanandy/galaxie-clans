help:
	@echo "--------------------------------------------------------------------"
	@echo "Galaxie Ansible Toolkit"
	@echo ""
	@echo "USAGE"
	@echo "	make sys-requirements  -- Install system requirements"
	@echo "	make hook-bash         -- Add direnv hook to ~/.bashrc"
	@echo "	make requirements      -- Install workspace requirements"
	@echo "	make first-date        -- Do sys-requirements + hook-bash + requirements"
	@echo ""
	@echo "FIRST DATE TOGETHER?"
	@echo ""
	@echo "	make first-date"
	@echo ""

sys-requirements:
	sudo apt-get install python3 python3-venv direnv -y

hook-bash:
	direnv hook bash >> ~/.bashrc

requirements:
	direnv allow .
	pip install -U -r requirements.txt --no-cache

first-date: sys-requirements hook-bash requirements

apply-role:
	ansible-playbook playbooks/clan-apply-single-role.yml -e name=${name}


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
