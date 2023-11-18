FROM python:3.11.3-alpine
LABEL maintainer="graeme.holliday@pm.me"

COPY ./requirements.txt /app/requirements.txt
COPY ./api /app/api
COPY ./demo /app/demo
COPY ./manage.py /app/manage.py
COPY ./.env /app/.env
COPY ./db.sqlite3 /app/db.sqlite3
WORKDIR /app

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /app/requirements.txt && \
    adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"

USER django-user

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]