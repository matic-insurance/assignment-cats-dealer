# frozen_string_literal: true

module Shops
  class CatsUnlimitedApi < BaseShopApi
    SHOP_KEY = 'cats_unlimited'

    def parse(data)
      JSON.parse(data)
    rescue JSON::ParserError => e
      Rails.logger.error e.backtrace
      []
    end

    def url
      'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'
    end

    def hash_to_cat(h)
      Cat.new(
        cat_type: h['name'],
        price: h['price'].to_i,
        location: h['location'],
        image_url: h['image'],
        shop_key: SHOP_KEY
      )
    end
  end
end
