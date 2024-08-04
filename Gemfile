# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.0'

gem 'rails', '~> 7.0.0'

gem 'dotenv-rails', require: 'dotenv/load'
gem 'puma'

group :development do
  gem 'listen', '~> 3.5'
end

group :development, :test do
  gem 'pry'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec', '~> 2.4'
end

group :test do
  gem 'rspec-rails', '~> 4.0.1'
  gem 'shoulda-matchers', '~> 5.3.0'
  gem 'vcr'
  gem 'webmock'
end
