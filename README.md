[![CircleCI](https://circleci.com/gh/bcdickinson/bbp.svg?style=svg&circle-token=33a0f73e51a4a9cf976a97afe081a2b288cacceb)](https://circleci.com/gh/bcdickinson/bbp)

# BBP
Bristol Bike Polo's website

## Infra TODO list
- [x] Heroku-ify image (`$PORT` etc.)
- [ ] Deployments from CircleCI
- [ ] Release phase stuff (migrations)
- [ ] Downstream caching (requires a domain)... Cloudflare?
  - [ ] Buy a dev domain
  - [ ] Setup Cloudflare
- [ ] Scheduling plugin (scheduled pages etc.)

## BE TODO list
- [ ] favicon
- [ ] base template
  - [ ] GA
  - [ ] Schema.org
- [ ] robots.txt
- [ ] sitemap
- [ ] 12 Factor shiz
  - [ ] Sentry integration
  - [ ] Scout integration

## FE TODO list
- [ ] Basic webpack build process
- [ ] Bootstrap
- [ ] Set up Sentry

## Common development tasks

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
