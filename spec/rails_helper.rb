require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = '#{::Rails.root}/spec/fixtures'
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
end

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = false
  config.cassette_library_dir = File.expand_path('cassettes', __dir__)
  config.hook_into :faraday
  config.ignore_localhost = true
  config.default_cassette_options = {
    record: :new_episodes
  }
end
