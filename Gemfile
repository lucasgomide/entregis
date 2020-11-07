source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'redis'
gem 'dry-rails'
gem 'dry-monads'

group :development, :test do
  gem 'pry-byebug'
end

group :development do
  gem 'rubocop-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'webmock'
  gem 'factory_bot_rails'
end
