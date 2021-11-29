# frozen_string_literal: true

module Api
  module V1
    class CatsController < ApplicationController
      def index
        result = Shops::FetchCats.call(filter_params)

        render json: {
          data: {
            cats: result.cat_list
          },
          shops: {
            processed: result.processed_shops,
            failed: result.failed_shops
          }
        }
      end

      private

      def filter_params
        params.permit(:location, :cat_type, shops: [])
              .to_h
              .symbolize_keys
      end
    end
  end
end
