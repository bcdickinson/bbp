[![CircleCI](https://circleci.com/gh/bcdickinson/bbp.svg?style=svg&circle-token=33a0f73e51a4a9cf976a97afe081a2b288cacceb)](https://circleci.com/gh/bcdickinson/bbp)

# BBP
Bristol Bike Polo's website


## To-do lists

### Infrastructure
- [ ] Deployments from CircleCI
- [x] S3 for media files
  - [ ] Some means of pulling them down for dev
- [ ] Downstream caching (requires a domain)... Cloudflare?
  - [ ] Buy a dev domain
  - [ ] Setup Cloudflare

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
  - [x] Set up Sentry
- [ ] Tooling
  - [ ] Webpack for all static assets
    - [x] Prod and dev configs
    - [x] JS files
    - [x] Sass files
    - [x] Autoprefixer for IE11 grid
    - [ ] Image files
    - [ ] SVG files


## Common development tasks

### Load DB backup

The database needs to be running for the following commands (`docker-compose start postgres`).
```sh
docker-compose exec postgres psql -Ubbp -c "DROP SCHEMA public CASCADE;"
docker-compose exec -T postgres pg_restore -O -Ubbp -dbbp < $BACKUP_FILE
```

### Debug the Django application (`pudb`)
- Run the app as normal
- Open another terminal and run `docker attach --detach-keys="ctrl-q" bbp_web_1` to connect to the running process
- Insert `breakpoint()` where you want the code to break
- When the code breaks, the debugger will appear in the terminal :100:
