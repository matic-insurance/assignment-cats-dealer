module Shops
  class CatsHappyService < CatsBaseService
    SHOP_NAME = 'CatsHappy'.freeze
    CACHE_KEY = SHOP_NAME.underscore.freeze
  end
end
