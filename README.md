[![CircleCI](https://circleci.com/gh/bcdickinson/bbp.svg?style=svg&circle-token=33a0f73e51a4a9cf976a97afe081a2b288cacceb)](https://circleci.com/gh/bcdickinson/bbp)

# BBP
Bristol Bike Polo's website


## To-do lists

### Infrastructure
- [ ] Deployments from CircleCI
- [x] S3 for media files
  - [ ] Some means of pulling them down for dev

### Backend
- [x] favicon
- [ ] GA
- [ ] Schema.org
- [ ] robots.txt
- [ ] sitemap

### Frontend
- [ ] CSS
  - [x] Basic layout styling
  - [ ] Streamblock styling
  - [x] Hero block
- [ ] JS
  - [ ] Mobile menu
- [ ] Tooling
  - [ ] Webpack for all static assets
    - [ ] Image files
    - [ ] SVG files


### Load DB backup

The database needs to be running for the following commands (`docker-compose start postgres`).
```sh
docker-compose exec postgres psql -Ubbp -c "DROP SCHEMA public CASCADE;"
docker-compose exec -T postgres pg_restore -O -Ubbp -dbbp < $BACKUP_FILE
```
