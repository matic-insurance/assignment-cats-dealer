require 'cats_dealers/adapters/base'
require 'cats_dealers/clients/base'
require 'cats_dealers/parsers/xml'

module CatsDealers
  module Adapters
    class HappyCats < Base
      class << self
        private

        def client
          CatsDealers::Clients::HappyCats.new
        end

        def wrap_response(parsed_response)
          parsed_response[:cats][:cat].map do |item|
            {
              breed: item[:title],
              price: item[:cost],
              location: item[:location],
              image: item[:img]
            }
          end
        end
      end
    end
  end
end
