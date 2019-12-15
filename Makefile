help:
	@echo "Galaxie Ansible Tool Kit"
	@echo ""
	@echo "USAGE"
	@echo "	make env - Create the virtual environement"
	@echo "	make requirements - Install requirements"

requirements: | env
	@echo "Make: Install requirements"
	. venv/bin/activate ;\
	pip install -U -r requirements.txt

env:
	@echo "Make: Create Virtual Environement"
	python3 -m venv venv
	. venv/bin/activate ;\
	pip install -U pip