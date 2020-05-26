# Load the Rails application.
require_relative 'application'
require 'dotenv'

if ENV['RAILS_ENV'] == 'development' || ENV['RAILS_ENV'] == 'test'
  Dotenv.load(".env.#{ENV['RAILS_ENV']}", '.env')
end

# Initialize the Rails application.
Rails.application.initialize!
