module Shops
  # this shop has 3 different keys, so we need to store them in different format
  module HappyCats
    def attribute_image(item)
      item['img']
    end

    def attribute_price(item)
      item['cost'].to_f
    end

    def attribute_name(item)
      item['title']
    end
  end
end
