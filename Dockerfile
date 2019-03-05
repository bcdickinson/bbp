##################
# Frontend build #
##################
FROM node:lts AS frontend-build

# TODO: replace this with npm scripts (use npm config variables in package.json)
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
COPY --chown=bbp --from=frontend-build /build/webpack-stats.json .
COPY --chown=bbp --from=frontend-build /build/bbp/static_build/ bbp/static_build/
RUN SECRET_KEY=null ./manage.py collectstatic --no-input

USER bbp

CMD gunicorn \
        --access-logfile - \
        --bind :${PORT} \
        --worker-class gevent \
        bbp.wsgi:application
