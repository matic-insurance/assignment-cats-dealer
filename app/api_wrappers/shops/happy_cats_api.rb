# frozen_string_literal: true

module Shops
  class HappyCatsApi < BaseShopApi
    SHOP_KEY = 'happy_cats'

    def parse(data)
      hash = Hash.from_xml(data)
      hash.dig('cats', 'cat')
    rescue REXML::ParseException => e
      Rails.logger.error e.backtrace
      []
    end

    def url
      'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
    end

    def hash_to_cat(h)
      Cat.new(
        cat_type: h['title'],
        price: h['cost'].to_i,
        location: h['location'],
        image_url: h['img'],
        shop_key: SHOP_KEY
      )
    end
  end
end
