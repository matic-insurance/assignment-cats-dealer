# frozen_string_literal: true

module Shops
  class FetchCats < BaseService
    AVAILABLE_SHOPS = %w[
      cats_unlimited
      happy_cats
    ].freeze

    def call(shops: AVAILABLE_SHOPS, **filter_params)
      shops &= AVAILABLE_SHOPS

      shops.each do |shop|
        cat_list.concat(
          api_for(shop).cat_list.where(filter_params)
        )
        processed_shops << shop
      rescue Exception => e
        Rails.logger.error e.backtrace
        # TODO: Send error to the bug tracker
        failed_shops << shop
      end

      Result.new(cat_list.sort_by(&:price), processed_shops, failed_shops)
    end

    private

    attr_reader :cat_list, :processed_shops, :failed_shops

    Result = Struct.new(:cat_list, :processed_shops, :failed_shops)

    def initialize
      @cat_list = CatList.new
      @processed_shops = []
      @failed_shops = []
    end

    def api_for(shop)
      "Shops::#{shop.camelize}Api".constantize.new
    end
  end
end
