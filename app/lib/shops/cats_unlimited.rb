module Shops
  # need to convert price to number format
  module CatsUnlimited
    def attribute_price(item)
      item['price'].to_f
    end
  end
end
