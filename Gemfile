source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'active_model_serializers'
gem 'activerecord-postgis-adapter'
gem 'cpf_cnpj'
gem 'dry-matcher'
gem 'dry-monads'
gem 'dry-rails'
gem 'hiredis'
gem 'kaminari'
gem 'money-rails'
gem 'paper_trail'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'redis'
gem 'rgeo-geojson'

group :development, :test do
  gem 'pry-byebug'
end

group :development do
  gem 'rubocop-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'webmock'
end

group :production do
  gem 'newrelic_rpm'
  gem 'sentry-raven'
end
