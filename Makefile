.PHONY: venv init lint test build run

venv:
	python -m venv .venv
	.venv/bin/pip install -r requirements.txt
	.venv/bin/pip install -r requirements-dev.txt

init:
	docker-compose run --rm app sh -c "django-admin startproject demo ."
	python manage.py makemigrations
	python manage.py migrate

lint:
	isort --check --diff api/ demo/
	flake8 --count --show-source --statistics api/ demo/
	mypy -p api
	mypy -p demo

test:
	python manage.py test

build:
	docker-compose build

run:
	docker-compose up
