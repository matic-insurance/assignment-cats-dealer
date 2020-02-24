module Shops
  class BaseShop
    def url
      raise NotImplementedError
    end

    def parser
      ShopParsers::Json
    end

    def prepare_response(response)
      decorate(parser.parse(response))
    end

    def client
      RestClient
    end

    def decorate(data)
      data
    end
  end
end
