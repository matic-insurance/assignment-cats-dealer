# frozen_string_literal: true

class Cat < BaseStruct
  attribute :type, Types::String
  attribute :price, Types::Coercible::Float
  attribute :location, Types::String
  attribute :image, Types::String
  attribute :shop_name, Types::String
end
