##################
# Frontend build #
##################

FROM node:8-alpine AS webpack

WORKDIR /app

COPY package*.json webpack.config.js ./
COPY bbp/static_src bbp/static_src

RUN npm ci && npm run build


##############
# Django app #
##############

FROM python:3.7-stretch

EXPOSE 8000
RUN useradd -m bbp

# Build args
ARG PIPENV_INSTALL_FLAGS

# Environment
ENV DJANGO_SETTINGS_MODULE bbp.settings.heroku
ENV PORT 8000
ENV PIPENV_INSTALL_FLAGS ${PIPENV_INSTALL_FLAGS:-""}
ENV PYTHONUNBUFFERED true
ENV WEB_CONCURRENCY 3

# Python dependencies
WORKDIR /app
RUN pip install pipenv
COPY Pipfile* ./
RUN pipenv install --system ${PIPENV_INSTALL_FLAGS}

# App and static files
COPY --chown=bbp . .
COPY --chown=bbp --from=webpack /app/bbp/static ./bbp/static/
RUN SECRET_KEY=null ./manage.py collectstatic --no-input

USER bbp

CMD gunicorn -c python:bbp.settings.gunicorn --bind :${PORT} bbp.wsgi:application
