require 'providers/models/base_cat'

module Providers
  module Models
    class KittyShop < BaseCat
      def initialize(attributes = {})
        @breed = attributes.fetch(:title, '')
        @price = attributes.fetch(:cost, '')
        @location = attributes.fetch(:location, '')
        @picture_url = attributes.fetch(:image, '')
      end
    end
  end
end
