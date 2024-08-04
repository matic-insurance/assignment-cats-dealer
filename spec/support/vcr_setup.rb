# frozen_string_literal: true

require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<CATS_UNLIMITED_URL>') { ENV.fetch('CATS_UNLIMITED_URL') }
  config.filter_sensitive_data('<HAPPY_CATS_URL>') { ENV.fetch('HAPPY_CATS_URL') }
end
