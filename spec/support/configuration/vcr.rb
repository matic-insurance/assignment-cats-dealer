VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr'

  config.hook_into :webmock

  config.before_record do |record|
    record.response.body.force_encoding('UTF-8')
  end
end
