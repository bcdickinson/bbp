.PHONY: help
help:
	@echo -e \
		"Available commands:\n" \
		"  up:             run the app\n" \
		"  upd:            run the app in the background\n" \
		"  stop:           stop the app\n" \
		"  shell:          run bash in the web (Django) container\n" \
		"  fe_shell:       run bash in the frontend (node) container\n" \
		"  makemigrations: make Django migrations\n" \
		"  migrate:        run Django migrations\n" \
		"  test:           run the tests"

yaml_files = -f docker-compose.yml -f docker-compose.dev.yml

.PHONY: up
up:
	docker-compose $(yaml_files) up --build

.PHONY: upd
upd:
	docker-compose $(yaml_files) up --build --detach

.PHONY: stop
stop:
	docker-compose $(yaml_files) stop


.PHONY: shell
shell:
	docker-compose $(yaml_files) run --rm web bash

.PHONY: fe_shell
fe_shell:
	docker-compose $(yaml_files) run --rm frontend bash

.PHONY: migrate
migrate:
	docker-compose $(yaml_files) run --rm web ./manage.py migrate

.PHONY: makemigrations
migrations:
	docker-compose $(yaml_files) run --rm web ./manage.py makemigrations

.PHONY: django_tests
django_tests:
	@echo "Django tests:"
	docker-compose $(yaml_files) run --rm web ./manage.py test -v2

.PHONY: node_tests
node_tests:
	@echo "Node tests:"
	docker-compose $(yaml_files) run --rm frontend npm run test

.PHONY: test
test: django_tests node_tests
