class RequestsController < ApplicationController
  def new
  end

  def create
    response = RestClient.get('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json')
    result = JSON.parse(response.body)
    result_params = {
      cats_list: result,
      cat_type: params[:breed],
      location: params[:location]
    }
    redirect_to request_path(result_params)
  end

  def show
    @cats_list = params[:cats_list].select do |list|
      list['location'] == params[:location] && list['name'] == params[:cat_type]
    end

    @best_price = @cats_list.sort_by { |list| list[:price] }.first['price'] if @cats_list.present?
  end
end
