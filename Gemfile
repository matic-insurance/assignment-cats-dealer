source 'https://rubygems.org'

# traslation tool
gem 'i18n', '~> 1.6.0'

# parsing XML and others
# gem 'nokogiri', '~> 1.10.9'

# for json parsing
gem 'multi_json', '~> 1.13.1'

gem 'puma', '~> 4.3.3'
gem 'rails', '~> 5.2.3'

# postgresql adapter
gem 'pg', '~> 1.1.4'

# generate UUID for DB
gem 'nanoid'

# no more counting stars we'll be counting dollars :)
gem 'money-rails', '~>1.12'

# cron tasks: one gem to rule them all
gem 'whenever', require: false

# simple REST api client
gem 'rest-client'

# bulk inserts for activerecord (remove when update to rails 6)
gem 'activerecord-import'

# fronend stuff
gem 'bootstrap-sass', '~> 3.4.1'
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'dotenv-rails'

  # pretty console
  gem 'pry-rails'

  # A Ruby static code analyzer, based on the community Ruby style guide.
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false

  # checking gems versions for vulnerabilities
  gem 'bundle-audit'

  # watching for updates of files
  gem 'listen'
end

group :development do
  # A fully configurable and extendable Git hook manager
  gem 'overcommit', require: false\
end

group :test do
  gem 'capybara'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'simplecov', require: false
  # Fabrication (mock objects)
  gem 'fabrication'
  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker'
end
