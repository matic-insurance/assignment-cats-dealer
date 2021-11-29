# frozen_string_literal: true

module Shops
  class Cat
    ATTRIBUTES = %i[cat_type price location image_url shop_key].freeze

    attr_reader(*ATTRIBUTES)

    def initialize(attributes = {})
      attributes.slice(*ATTRIBUTES).each do |attr, value|
        instance_variable_set("@#{attr}", value)
      end
    end

    def to_h
      ATTRIBUTES.map do |attr|
        [attr, send(attr)]
      end.to_h
    end
  end
end
