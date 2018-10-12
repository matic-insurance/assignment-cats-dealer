module Api
  class CatsController < BaseController
    def index
      render json: filtered, each_serializer: CatSerializer
    end

    private

    def filtered
      filter_params = {}

      filter_params[:location] = params[:location] unless params[:location].nil?
      filter_params[:name] = params[:name] unless params[:name].nil?

      @filtered ||= all.where(filter_params).order(:price)
    end

    def all
      @all ||= Cat.all
    end
  end
end
