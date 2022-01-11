require 'cats_dealers/adapters/base'
require 'cats_dealers/clients/base'
require 'cats_dealers/parsers/json'

module CatsDealers
  module Adapters
    class CatsUnlimited < Base
      class << self
        private

        def client
          CatsDealers::Clients::CatsUnlimited.new
        end

        def wrap_response(parsed_response)
          parsed_response.map do |item|
            {
              breed: item[:name],
              price: item[:price],
              location: item[:location],
              image: item[:image]
            }
          end
        end
      end
    end
  end
end
