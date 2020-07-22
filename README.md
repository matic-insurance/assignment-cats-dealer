### Setup development environment
commands to run:
```
docker-compose up -d
docker-compose exec app bundle exec rake db:create db:migrate db:seed
```

### Setup test environment
to setup the test database simply run:
```
docker-compose exec app bundle exec rake db:migrate RAILS_ENV=test
```

to run tests:
```
docker-compose exec app rspec
```