RSpec.configure do |config|
  config.around do |example|
    DatabaseCleaner.cleaning(&example)
  end
end
