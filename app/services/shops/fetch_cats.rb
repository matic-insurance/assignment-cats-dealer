# frozen_string_literal: true

module Shops
  class FetchCats < BaseService
    AVAILABLE_SHOPS = %w[
      cats_unlimited
      happy_cats
    ].freeze

    def call(shops: AVAILABLE_SHOPS, **filter_params)
      shops &= AVAILABLE_SHOPS

      cat_list = CatList.new
      shops.each do |shop|
        cat_list.concat(
          api_for(shop).cat_list.where(filter_params)
        )
      end

      cat_list.sort_by(&:price)
    end

    private

    def api_for(shop)
      "Shops::#{shop.camelize}Api".constantize.new
    end
  end
end
