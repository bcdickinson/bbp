# Frontend build
FROM node:8-alpine AS frontend

WORKDIR /app

COPY package*.json webpack.config.js ./
COPY bbp/static_src bbp/static_src

RUN npm ci && npm run build


# Django app
FROM python:3.7-stretch

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE bbp.settings.production

WORKDIR /app

RUN useradd -m bbp

RUN apt-get update
RUN pip install pipenv

COPY --chown=bbp . .

RUN pipenv install --system

USER bbp

CMD gunicorn bbp.wsgi:application
