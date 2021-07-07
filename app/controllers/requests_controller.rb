class RequestsController < ApplicationController
  def show
    result = JSON.parse(response.body)
    result_params = {
      cats_list: result,
      cat_type: params[:cats_type],
      location: params[:user_location]
    }.to_json

    render json: result_params
  end

  def result
    @cats_list = params[:cats_list].select do |list|
      list['location'] == params[:location] && list['name'] == params[:cat_type]
    end
  end
end
