# frozen_string_literal: true

module Api
  module V1
    class CatsController < ApplicationController
      def index
        cat = CatFinderService.call(search_params[:location], search_params[:cat_type])

        render json: cat
      end

      private

      def search_params
        params.permit(:location, :cat_type)
      end
    end
  end
end
