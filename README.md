[![CircleCI](https://circleci.com/gh/bcdickinson/bbp.svg?style=svg&circle-token=33a0f73e51a4a9cf976a97afe081a2b288cacceb)](https://circleci.com/gh/bcdickinson/bbp)

# bbp
Bristol Bike Polo's website

## Infra TODO list
- [ ] Downstream caching (requires a domain)
  
## BE TODO list
- [ ] Dockerise (buildpacks are faff)
- [ ] Whitenoise
- [ ] favicon
- [ ] base template
  - [ ] GA
  - [ ] wagtail-schema.org!
- [ ] Scheduling plugin (scheduled pages etc.)
  
## FE TODO list
- [ ] Basic webpack build process
- [ ] Bootstrap
- [ ] Set up Sentry

## Regenerating lockfiles for a new image

```sh
npm install --package-lock-only
pipenv lock
```
