module Shops
  class CatsUnlimitedService < CatsBaseService
    SHOP_NAME = 'CatsUnlimited'.freeze
    CACHE_KEY = SHOP_NAME.underscore.freeze
  end
end
