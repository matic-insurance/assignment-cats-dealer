require_relative 'boot'

require 'rails/all'

require_relative '../app/services/cats/shops/cats_unlimited'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module Cats
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.sqlite3.represent_boolean_as_integer = true
    config.api_only = true

    config.available_cat_shops = [
      ::Cats::Shops::CatsUnlimited.new
    ]
  end
end
