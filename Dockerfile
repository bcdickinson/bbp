##################
# Frontend build #
##################
FROM node:12 AS frontend-build

WORKDIR /build
COPY package*.json webpack.*.js postcss.config.js ./
COPY bbp/static_src/ bbp/static_src/
RUN npm ci && \
    npx webpack --config webpack.prod.js

##############
# Django app #
##############
FROM python:3.7-stretch

EXPOSE 8000
RUN useradd -m bbp && \
    mkdir /var/media && \
    chown bbp:bbp /var/media && \
    curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python

# Environment
ENV DJANGO_SETTINGS_MODULE bbp.settings.prod
ENV POETRY /root/.poetry/bin/poetry
ENV PORT 8000
ENV PYTHONUNBUFFERED true
ENV WEB_CONCURRENCY 4

# Python dependencies
WORKDIR /app
COPY pyproject.toml poetry.lock ./
RUN $POETRY config settings.virtualenvs.create false && \
    $POETRY install --no-dev --no-interaction --no-ansi

# App and static files
COPY --chown=bbp . .
COPY --chown=bbp --from=frontend-build /build/webpack-stats.json .
COPY --chown=bbp --from=frontend-build /build/bbp/static_build/ bbp/static_build/
RUN SECRET_KEY=None ./manage.py collectstatic --no-input

USER bbp

CMD gunicorn \
    --bind :${PORT} \
    --access-logfile - \
    --error-logfile - \
    --worker-class gevent \
    bbp.wsgi:application
