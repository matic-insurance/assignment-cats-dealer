require 'providers/models/json_attributes'

module Providers
  module Models
    class BaseCat
      attr_accessor :breed, :price, :location, :picture_url

      def initialize(attributes); end
    end
  end
end
