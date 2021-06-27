class CatsController < ApplicationController
  def index
    response = RestClient.get('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json')
    result = JSON.parse(response.body)
    result_params = {
      cats_list: result,
      cat_type: params[:cats_type],
      location: params[:user_location]
    }
    redirect_to result_cats_path(result_params)
  end

  def result
    @cats_list = params[:cats_list].select do |list|
      list['location'] == params[:location] && list['name'] == params[:cat_type]
    end
  end
end
