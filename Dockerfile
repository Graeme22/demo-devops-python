FROM python:3.11.3-alpine
LABEL maintainer="graeme.holliday@pm.me"

COPY ./requirements.txt /requirements.txt
COPY ./api /app
WORKDIR /app

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt && \
    adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"

USER django-user

EXPOSE 8080

CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]