[![CircleCI](https://circleci.com/gh/bcdickinson/bbp.svg?style=svg&circle-token=33a0f73e51a4a9cf976a97afe081a2b288cacceb)](https://circleci.com/gh/bcdickinson/bbp)

# bbp
Bristol Bike Polo's website

## Infra TODO list
- [ ] Downstream caching (requires a domain). Cloudflare?
- [ ] Heroku-ify image ($PORT etc.)
  
## BE TODO list
- [ ] favicon
- [ ] base template
  - [ ] GA
  - [ ] wagtail-schema.org!
- [ ] Scheduling plugin (scheduled pages etc.)
  
## FE TODO list
- [ ] Basic webpack build process
- [ ] Bootstrap
- [ ] Set up Sentry

## Development tasks

Common dev task cheat sheet.

### Regenerating lockfiles for a new image

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
