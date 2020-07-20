### Roll out development environment
#### run commands
```
docker-compose up -d
docker-compose exec app bundle exec rake db:setup db:migrate
```