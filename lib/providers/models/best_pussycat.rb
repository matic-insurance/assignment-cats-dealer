require 'providers/models/base_cat'
require 'providers/models/json_attributes'

module Providers
  module Models
    class BestPussycat < BaseCat
      def initialize(attributes = {})
        @breed = attributes.fetch(:name, '')
        @price = attributes.fetch(:price, '')
        @location = attributes.fetch(:location, '')
        @picture_url = attributes.fetch(:image, '')
      end
    end
  end
end
