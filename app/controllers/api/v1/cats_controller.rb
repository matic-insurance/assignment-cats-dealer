# frozen_string_literal: true

module Api
  module V1
    class CatsController < ApplicationController
      before_action :validate_order_by_param, only: :index

      def index
        result = Shops::FetchCats.call(list_params)

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

      def list_params
        params.permit(:location, :cat_type, :order_by, shops: [])
              .to_h
              .symbolize_keys
      end

      def validate_order_by_param
        if params[:order_by].present? && !Shops::Cat.valid_attribute?(params[:order_by].to_sym)
          render json: {
            error: 'order_by has invalid value'
          }, status: :bad_request
        end
      end
    end
  end
end
