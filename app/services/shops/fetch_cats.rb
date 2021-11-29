# frozen_string_literal: true

module Shops
  class FetchCats < BaseService
    AVAILABLE_SHOPS = %w[
      cats_unlimited
      happy_cats
    ].freeze

    Result = Struct.new(:cat_list, :processed_shops, :failed_shops)

    def call(shops: AVAILABLE_SHOPS, order_by: :price, **filter_params)
      shops &= AVAILABLE_SHOPS

      shops.each do |shop|
        fetch_cats_from(shop, filter_params)
      end

      cat_list.sort_by!(&order_by.to_sym)

      Result.new(
        cat_list,
        processed_shops,
        failed_shops
      )
    end

    private

    attr_reader :cat_list, :processed_shops, :failed_shops

    def initialize
      @cat_list = CatList.new
      @processed_shops = []
      @failed_shops = []
      super
    end

    def fetch_cats_from(shop, filter_params)
      cat_list.concat(
        api_for(shop).cat_list.where(filter_params)
      )
      processed_shops << shop
    rescue StandardError
      # TODO: Send error to the bug tracker
      failed_shops << shop
    end

    def api_for(shop)
      "Shops::#{shop.camelize}Api".constantize.new
    end
  end
end
