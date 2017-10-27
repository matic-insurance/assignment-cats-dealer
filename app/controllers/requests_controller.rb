class RequestsController < ApplicationController
  def create
    response = RestClient.get('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json')
    result = JSON.parse(response.body)
    redirect_to result_request_path(cats_list: result, cat_type: params[:cats_type], location: params[:user_location])
  end

  def result
    @cats_list = params[:cats_list].select { |list| list['location'] == params[:location] && list['name'] ==  params[:cat_type]}
  end
end
