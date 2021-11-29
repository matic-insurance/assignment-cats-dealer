# frozen_string_literal: true

module Api
  module V1
    class CatsController < ApplicationController
      def index
        cats = Shops::FetchCats.call(filter_params)

        render json: {
          cats: cats
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
