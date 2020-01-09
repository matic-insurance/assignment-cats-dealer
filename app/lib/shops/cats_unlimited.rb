module Shops
  # need to convert price to number format
  module ShopOne

    def attribute_price(item)
      item['price'].to_f
    end

  end
end
