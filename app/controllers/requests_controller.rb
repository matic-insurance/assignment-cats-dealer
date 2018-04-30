class RequestsController < ApplicationController
  def create
    @cats_list = search_service.find_by(search_params)
    render :result
  end

  private

  def search_params
    params.permit(:breed, :location).reject { |_, value| value.empty? }
  end

  def search_service
    CatsServices::SearchService
  end
end
