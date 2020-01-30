help:
	@echo "Galaxie Ansible Tool Kit"
	@echo ""
	@echo "USAGE"
	@echo "	make env - Create the virtual environement"
	@echo "	make requirements - Install requirements"

test:
	. venv/bin/activate;\
	PREV_DIR=$$PWD;\
	GLX_ROLES_DIR=$$(realpath $$(echo "$$PWD/roles"));\
	for ROLE in $$(find $$GLX_ROLES_DIR -mindepth 1 -maxdepth 1 -type d); do \
		ROLE_NAME=$$(basename $$ROLE);\
		echo "$$ROLE_NAME";\
		cd $$GLX_ROLES_DIR/$$ROLE_NAME;\
		echo "$$PWD";\
	done;\
	cd $$PREV_DIR

requirements: | env
	@echo "Make: Install requirements"
	. venv/bin/activate ;\
	pip install -U -r requirements.txt

env:
	@echo "Make: Create Virtual Environement"
	python3 -m venv venv
	. venv/bin/activate ;\
	pip install -U pip