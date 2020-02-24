module ShopDecorators
  class HappyCats
    def initialize(items)
      @items = items
    end

    def decorate
      items[:cats][:cat].map { |item| decorated_items << map_item(item) }

      decorated_items
    end

    private

    attr_reader :items

    def map_item(item)
      {
        name: item[:title],
        price: item[:cost],
        location: item[:location],
        image: item[:img]
      }
    end

    def decorated_items
      @decorated_items ||= []
    end
  end
end
