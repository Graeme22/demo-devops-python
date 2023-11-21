.PHONY: venv init lint test build run

venv:
	python -m venv .venv
	.venv/bin/pip install -r requirements.txt
	.venv/bin/pip install -r requirements-dev.txt

init:
	docker-compose run --rm app sh -c "django-admin startproject demo ."
	.venv/bin/python manage.py makemigrations
	.venv/bin/python manage.py migrate

lint:
	.venv/bin/isort --check --diff api/ demo/
	.venv/bin/flake8 --count --show-source --statistics api/ demo/

test:
	.venv/bin/coverage run manage.py test
	.venv/bin/coverage report --fail-under=95

build:
	docker-compose build

run:
	docker-compose up
