require 'async/http/faraday'

module V1
  class CatsController < ApplicationController
    def index
      render json: {data: collection}
    end

    private

    def collection
      @collection ||= Shops::FindCheaper::Organize.call(query_params:).record
    end

    def query_params
      params.permit(:name, :location)
    end
  end
end
