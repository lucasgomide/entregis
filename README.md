# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


`Testing`

docker-compose run -rm -e RAILS_ENV=test -e DATABASE_URL="postgresql://postgres:password@db:5432/entregis_test" web bundle exec rails db:create

docker-compose run -rm -e RAILS_ENV=test -e DATABASE_URL="postgresql://postgres:password@db:5432/entregis_test" web bundle exec rspec


`Setup`

heroku create entregis --manifest
docker-compose run -e EDITOR=vi web rails credentials:edit && heroku config:set RAILS_MASTER_KEY=`cat config/master.key` -a entregis

bundle exec rails db:gis:setup

git push heroku master
