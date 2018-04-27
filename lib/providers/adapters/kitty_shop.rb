require 'providers/adapters/base'
require 'providers/clients/kitty_shop'
require 'providers/models/kitty_shop'

module Providers
  module Adapters
    class KittyShop < Base
      protected

      def client
        Providers::Clients::KittyShop.new
      end

      def base_model
        Providers::Models::KittyShop
      end

      def wrap(parsed_response)
        super(parsed_response[:cats][:cat])
      end
    end
  end
end
