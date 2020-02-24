module Shops
  class HappyCats < BaseShop
    def url
      Rails.configuration.search['shops']['happy_cats']['url']
    end

    def parser
      ShopParsers::Xml
    end

    def decorate(data)
      ShopDecorators::HappyCats.new(data).decorate
    end
  end
end
