require 'cats_dealers/clients/base'
require 'cats_dealers/parsers/xml'

module CatsDealers
  module Clients
    class HappyCats < Base
      private

      def parser
        CatsDealers::Parsers::Xml.new
      end

      def url
        'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'.freeze
      end
    end
  end
end
