FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client libproj-dev nodejs less

RUN mkdir /app

WORKDIR /app

COPY Gemfile* /app/

RUN gem install bundler && bundle install
COPY . /app/

EXPOSE 3000
