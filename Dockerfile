FROM python:3.9-alpine3.13
LABEL maintainer="londonappdeveloper.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN apk add --no-cache bash && \
    pip install --upgrade pip && \
    pip install virtualenv && \
    virtualenv /py && \
    source /py/bin/activate && \
    pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; then pip install -r /tmp/requirements.dev.txt ; fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
