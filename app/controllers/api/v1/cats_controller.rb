module Api
  module V1
    class CatsController < ::Api::V1::BaseController
      def index
        service = ::Cats::LookupBestDeal.new(sources: sources)
        record = service.call(location: params[:location], cat_type: params[:cat_type])

        render json: record
      end

      private

        def sources
          Rails.application.config.available_cat_shops
        end
    end
  end
end
