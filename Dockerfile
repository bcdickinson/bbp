##################
# Frontend build #
##################
FROM node:lts AS frontend-build

WORKDIR /sass-build
COPY package*.json ./
COPY bbp/static_src/scss bbp/static_src/scss
RUN npm ci && \
    mkdir -p bbp/static_build/css && \
    npx sass bbp/static_src/scss/main.scss:bbp/static_build/css/main.css


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
RUN pipenv install --system --deploy ${PIPENV_INSTALL_FLAGS}

# App and static files
COPY --chown=bbp . .
COPY --chown=bbp --from=frontend-build /sass-build/bbp/static_build/css/main.css bbp/static_build/css/main.css
RUN SECRET_KEY=null ./manage.py collectstatic --no-input

USER bbp

CMD gunicorn \
        --access-logfile - \
        --bind :${PORT} \
        --worker-class gevent \
        bbp.wsgi:application
