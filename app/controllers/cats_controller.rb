class CatsController < ApplicationController
  def index
    result = ::Cats::FetchingService.call
    render json: result
  end

  # def result
  #   @cats_list = params[:cats_list].select do |list|
  #     list['location'] == params[:location] && list['name'] == params[:cat_type]
  #   end
  # end
end
