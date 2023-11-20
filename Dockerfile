FROM python:3.11.3-alpine
LABEL maintainer="graeme.holliday@pm.me"

COPY ./ /app
WORKDIR /app

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /app/requirements.txt

ENV PATH="/py/bin:$PATH"

EXPOSE 8000

CMD ["/py/bin/python", "manage.py", "runserver"]