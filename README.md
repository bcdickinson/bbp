[![CircleCI](https://circleci.com/gh/bcdickinson/bbp.svg?style=svg&circle-token=33a0f73e51a4a9cf976a97afe081a2b288cacceb)](https://circleci.com/gh/bcdickinson/bbp)

# BBP
Bristol Bike Polo's website


## To-do lists

### Infrastructure
- [x] Heroku-ify image (`$PORT` etc.)
- [ ] Deployments from CircleCI
- [ ] Release phase stuff (migrations)
  - https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#release-configuring-release-phase
- [x] S3 for media files
  - [ ] Some means of pulling them down for dev
- [ ] Downstream caching (requires a domain)... Cloudflare?
  - [ ] Buy a dev domain
  - [ ] Setup Cloudflare
- [ ] Scheduling plugin (scheduled pages etc.)

### Backend
- [x] favicon
- [ ] base template
  - [ ] GA
  - [ ] Schema.org
- [ ] robots.txt
- [ ] sitemap
- [ ] 12 Factor shiz
  - [x] Sentry integration
  - [x] Scout integration

### Frontend
- [ ] CSS
  - [ ] Basic layout styling
  - [ ] Streamblock styling
  - [ ] Hero block
- [ ] JS
  - [ ] Set up Sentry
- [ ] Tooling
  - [ ] Webpack for all static assets
    - [x] Prod and dev configs
    - [ ] Update package.json and Dockerfile to use npm scripts for FE build
    - [ ] Image files
    - [ ] SVG files
    - [x] JS files
    - [ ] Sass files
    - [ ] Autoprefixer for IE11 grid

### Far-future craziness
- [ ] PWA for tournament stuff

## Common development tasks

### Running the web service container with local files

```sh
 docker-compose run -d --service-ports -v $(pwd):/app web
```

### Regenerating lockfiles for a new image

The following commands can be used to update just the lock files without installing anything.

```sh
npm install --package-lock-only
pipenv lock
```
### Local interactive debugging with modified code

The app image needs to have the dev dependencies installed (includes `pudb`):

```sh
docker-compose build --build-arg PIPENV_INSTALL_FLAGS=--dev web
```
Now you can add some debug code, `set_trace()` calls, etc. to your local code.
Then you can run the server with the modified code (no need to rebuild the image):

```sh
docker-compose run --rm -e PYTHONDONTWRITEBYTECODE=1 -v $(pwd):/app web
```

_NB - There's a probably a way to do this with `pudb` installed on the host and shared to the container
via a volume, but rebuilding the image is fine for now._

### Load DB backup

The database needs to be running for the following commands (`docker-compose start postgres`).

```sh
docker-compose exec postgres psql -Ubbp -c "DROP SCHEMA public CASCADE;"
docker-compose exec -T postgres pg_restore -O -Ubbp -dbbp < $BACKUP_FILE
```
### Fix "permission denied" errors when uploading media

Annoyingly, you can't specify the user and group of a volume when it's created (it will always be `root:root`),
so you have to manually `chown` the mount once the container has been created:
```sh
docker-compose run --rm --user root web chown bbp:bbp media/
```
