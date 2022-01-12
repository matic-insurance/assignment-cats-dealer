module Api
  module V1
    class CatsDealersController < ApplicationController
      def index
        all_cats = CatsDealers::FetchService.call
        matched_cats = CatsDealers::SearchService.call(all_cats, search_params.to_h)
        json_response(matched_cats)
      end

      private

      def search_params
        params.permit(:breed, :location, :price).reject { |_, value| value.blank? }
      end
    end
  end
end
