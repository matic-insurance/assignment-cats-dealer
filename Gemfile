source 'https://rubygems.org'
ruby '3.2.4'

gem 'mime-types', '~> 3.3', '>= 3.3.1'                 # A library for dealing with MIME types
gem 'puma', '~> 6.4', '>= 6.4.2'                        # Webserver for Rails
gem 'rails', '~> 7.1', '>= 7.1.3.4'                     # Ruby on Rails is a full-stack web framework.
gem 'rest-client', '~> 2.1'                             # REST client for making API requests

group :development do
  gem 'dotenv-rails', '~> 3.1', '>= 3.1.2'              # Allows developers to override ENV variables
  gem 'listen', '~> 3.7', '>= 3.7.0'                    # The Listen gem listens to file modifications and notifies you about the changes.
  gem 'magic_frozen_string_literal', '~> 1.2'           # Magic comment for frozen string literals
  gem 'rails_best_practices', '~> 1.23.2'               # a code metric tool for rails codes, written in Ruby.
  gem 'rubocop', '~> 1.64', '>= 1.64.0', require: false # A Ruby static code analyzer https://github.com/bbatsov/rubocop
  gem 'rubocop-performance', '~> 1.21', '>= 1.21.1', require: false # A rubocop Performance extension
  gem 'rubocop-rails', '~> 2.25', '>= 2.25.1', require: false # A rubocop extension to support rails
end

group :test do
  gem 'rspec-rails', '~> 6.1', '>= 6.1.2'               # rspec-rails is a testing framework for Rails 3+.
  gem 'rubocop-rspec', '~> 2.30', '>= 2.30.0'           # Code style checking for RSpec files
  gem 'shoulda-callback-matchers', '~> 1.1.4'           # Matchers to test before, after and around hooks
  gem 'shoulda-matchers', '~> 6.2'                      # Collection of testing matchers extracted from Shoulda http://thoughtbot.com/community
  gem 'simplecov', require: false                       # To help calculate test coverage percentage: https://github.com/simplecov-ruby/simplecov
  gem 'webmock', '~> 3.23', '>= 3.23.1'                 # To stub RestClient requests
end
