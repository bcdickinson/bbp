.PHONY: help
help:
	@echo -e \
		"Available commands:\n" \
		"  up:             run the app\n" \
		"  upd:            run the app in the background\n" \
		"  shell:          run bash in the web (Django) container\n" \
		"  fe_shell:       run bash in the frontend (node) container\n" \
		"  makemigrations: make Django migrations\n" \
		"  migrate:        run Django migrations\n" \
		"  test:           run the tests"

.PHONY: up
up:
	exec docker-compose up --build

.PHONY: upd
upd:
	exec docker-compose up --build --detach

.PHONY: shell
shell:
	exec docker-compose run --rm web bash

.PHONY: fe_shell
fe_shell:
	exec docker-compose run --rm frontend bash

.PHONY: migrate
migrate:
	exec docker-compose run --rm web ./manage.py migrate

.PHONY: makemigrations
makemigrations:
	exec docker-compose run --rm web ./manage.py makemigrations

.PHONY: django_tests
django_tests:
	echo "Django tests:"
	docker-compose run --rm web ./manage.py test -v2

.PHONY: node_tests
node_tests:
	echo "Node tests:"
	docker-compose run --rm frontend npm run test

.PHONY: test
test: django_tests node_tests
