require 'vcr'
require 'webmock/rspec'
require 'capybara/rspec'

RSpec.configure do |config|
  VCR.configure do |c|
    c.hook_into :webmock
    c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
    c.configure_rspec_metadata!
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
