require 'providers/clients/base'
require 'providers/parsers/generic_xml'

module Providers
  module Clients
    class KittyShop < Base
      protected

      def parser
        Providers::Parsers::GenericXML.new
      end

      def hostname
        fetch_variable('KITTY_SHOP_HOST')
      end

      def path
        'dev/cats/xml'.freeze
      end
    end
  end
end
