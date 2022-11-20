# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.6'

gem 'benchmark'
gem 'dry-initializer', '~> 3.1.1'
gem 'dry-struct', '~> 1.4.0'
gem 'parallel', '~> 1.22.1'
gem 'puma', '~> 6.0.0'
gem 'rails', '~> 7.0.4'
gem 'rest-client', '~> 2.1.0'
gem 'sqlite3', '~> 1.5.3'

group :development, :test do
  gem 'pry'
  gem 'rubocop'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.7.1'
  gem 'web-console', '~> 4.2.0'
end

group :test do
  gem 'rspec-rails', '~> 6.0.1'
  gem 'webmock'
end
