## Setup development environment
*launch containers:*
```
docker-compose up -d
docker-compose exec app bundle exec rake db:create db:migrate db:seed
```

## Setup test environment
*Setup the database:*
```
docker-compose exec app bundle exec rake db:migrate RAILS_ENV=test
```

*Running specs:*
```
docker-compose exec app rspec
```