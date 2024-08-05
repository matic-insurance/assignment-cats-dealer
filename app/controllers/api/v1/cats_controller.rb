# frozen_string_literal: true

module Api
  module V1
    class CatsController < ApplicationController
      def best_deal
        best_deal = CatDealerService.find_best_deal(best_deal_params[:user_location], best_deal_params[:cats_type])

        render json: best_deal, status: :ok
      end

      private

      def best_deal_params
        params.permit(:user_location, :cats_type)
      end
    end
  end
end
