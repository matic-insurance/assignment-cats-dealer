require 'dry-initializer'
require 'dry-types'

class AllCats
  extend Dry::Initializer

  SHOPS                 = %w[Cats\ Unlimited Happy\ Cats].freeze
  EMPTY_STRING          = ''.freeze
  MISSING_ADAPTER_ERROR = 'Please define an adapter for the new shop'.freeze

  def call
    SHOPS.map do |shop_name|
      ShopAdapter.new.send(shop_name.gsub(/\s+/, EMPTY_STRING).underscore)
    rescue NoMethodError
      raise StandardError, MISSING_ADAPTER_ERROR
    end.flatten
  end
end
