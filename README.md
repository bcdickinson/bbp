[![CircleCI](https://circleci.com/gh/bcdickinson/bbp.svg?style=svg&circle-token=33a0f73e51a4a9cf976a97afe081a2b288cacceb)](https://circleci.com/gh/bcdickinson/bbp)

# BBP
Bristol Bike Polo's website


## To-do lists

### Infrastructure
- [ ] heroku.yml for deployments
  - [ ] Release phase stuff (migrations)
    - https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#release-configuring-release-phase
- [ ] Deployments from CircleCI
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
  - [x] Hero block
- [ ] JS
  - [ ] Mobile menu
  - [ ] Set up Sentry
- [ ] Tooling
  - [ ] Webpack for all static assets
    - [x] Prod and dev configs
    - [x] JS files
    - [x] Sass files
    - [x] Autoprefixer for IE11 grid
    - [ ] Image files
    - [ ] SVG files


## Common development tasks

### Running the in development mode

```sh
docker-compose up
```
### Regenerating lockfiles for a new image

The following commands can be used to update just the lock files without installing anything.

```sh
npm install --package-lock-only
poetry update
```
### Load DB backup

The database needs to be running for the following commands (`docker-compose start postgres`).

```sh
docker-compose exec postgres psql -Ubbp -c "DROP SCHEMA public CASCADE;"
docker-compose exec -T postgres pg_restore -O -Ubbp -dbbp < $BACKUP_FILE
```
