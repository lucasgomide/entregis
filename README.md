# Entregis

Entregis is an app to connect customers with the carrier. By providing a service to create freight with items, the customer can find the either cheapest or closest carrier.

## Application

What is under this app? It's a basic Rails API. The data is serialized with [active-model-serializer](https://github.com/rails-api/active_model_serializers) using [JSON-API](https://jsonapi.org/) as adapter. The data are stored on Postgres, the postgis was enabled to store some geography/geometric data.
The [dry-rb](https://dry-rb.org/) is being used for dependency management system, data validation, operations, and data type definition.

Why I've chosen this kind of stack instead of another one.

_At first, why Rails?_ Rails is such modular. Earning the active-record (ORM) I was able to include the activerecord-postgis-adapter to handle better geometric data types. The Rails give me more power to build a modular and flexibility application.

_What about Active Model Serializer?_ I have used in all applications to serialize data. It's modular, easy configuration, and have support for JSON API.

_What about JSON API?_ It's important to define application standards. I'd say the serializer is one sensitive part of the application system. Usually, it can have pagination, metadata, results... The JSON API has a specification for building APIs in JSON. That's great for the following reason: Is hard to define a standard, you can take a lot of time to define your response. JSON API has already done it. I can focus on what matters: the application.

_What about Postgres?_ I was thinking about what kind of approach. So, I took my decision thinking about a real project. Thinking about costs and manageability. Postgres is a powerful database store. Writing and reading are extremely fast operation and easy to manage. I've chosen Postgres thinking mainly about costs and manageability.

_What about Dry-rb?_ Rails is simple, based on MVC architecture. The problem of this approach is business logic belongs in models, it works well for small applications, but they grow and can find business logic spread. It's hard to follow DRY principle. The dry-rb offers to developers an ecosystem of gems that could help build healthy architecture. I'm using some essentials features/plugins of, such as: `dry-matcher`, `dry-monad` and `dry-container`.
Basically, `dry-matcher` offers a flexible, expressive pattern matching for Monad Result.
The `dry-monad` is a set of common monads for Ruby. Monads provide an elegant way of handling errors, exceptions and chaining functions so that the code is much more understandable and has all the error handling, without all the ifs and else.
The `dry-container` is a simple, thread-safe container, intended to be one half of a dependency injection system.


### Roadmap

A [board on Trello](https://trello.com/b/cPzsXWj1/entregis) has been created for developing tracking and management.

*Some most important missing features*

- [ ] Adding `available_filters` into response's metadata
- [ ] Support to _relevant_ filter for the best carriers for a freight.
- [ ] Use other attributes to calculate the shipment cost. It would be great to support pricing by weight,
fixed vehicle cost, distance in time.
- [ ] Idempotent endpoint. That's a really nice feature.

## Getting Started

### Prerequisites

In order to run this app, you'll need Docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

See the [Docker website](http://www.docker.io/gettingstarted/#h_installation) for installation instructions.

### Endpoints documentation

All endpoints were created and documented with Postman [check out here](https://documenter.getpostman.com/view/949653/TVewY3xT).

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/f4a5153deab7a5a96735#?env%5BEntregis%20-%20Production%5D=W3sia2V5IjoiZW5kcG9pbnQiLCJ2YWx1ZSI6Imh0dHBzOi8vZW50cmVnaXMuaGVyb2t1YXBwLmNvbSIsImVuYWJsZWQiOnRydWV9XQ==)



### Deployment

We're using Heroku as PAAS for this app. The command `git push heroku master` that's enough to deploy it.

#### Configuring

This app is using a heroku manifest to define the app configuration. Thus, you can create your app from a "setup", just run the following commands below.

```bash
$ export APP_NAME='entregis'
$ heroku create $APP_NAME --manifest
$ docker-compose run --rm -e EDITOR=vi web rails credentials:edit && heroku config:set RAILS_MASTER_KEY=`cat config/master.key` -a $APP_NAME
$ heroku pg:psql -c 'create extension postgis;'
$ heroku run rails db:seed
```

### Monitoring

We're using NewRelic as Monitoring APM.

### Error Tracker

We're using Rollbar as Tracking Error.

### Benchmarking

[See details](benchmarking/)

### Development

We're using docker-compose to increase the developing time. That's simple, check out the following code:

```bash
$ docker-compose build --pull
$ docker-compose run --rm web bundle exec rails db:setup

$ docker-compose up # (starting web server and database)
```

#### Debugging

We're using `pry-byebug` for debuggin'. Just put `binding.pry` into the code and run the following code:

```bash
$ docker attach $(docker-compose ps -q web)
```

#### Linter

We're using Rubocop as linter. To lint the code just run:

```bash
$ docker-compose run --rm web bundle exec rubocop
```

### Testing

This project is using RSpec on test suite.

#### Setup

At first, you must create the test database

```bash
$ docker-compose run --rm -e RAILS_ENV=test web bundle exec rails db:create
```

#### Usage

```bash
$ docker-compose run --rm web bundle exec rspec
```
