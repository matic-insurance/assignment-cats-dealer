module Shops
  class CatsUnlimited < BaseShop
    def url
      Rails.configuration.search['shops']['cats_unlimited']['url']
    end
  end
end
