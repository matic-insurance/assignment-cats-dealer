class RequestsController < ApplicationController
  def get_kitties
    cat_breed = params[:cat_breed]
    location = params[:location]

    get_data_from_api = RestClient::Request.execute(
      method: :get,
      url: 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json',
    )

    @kitties_list = JSON.parse(get_data_from_api)
                       .select { |list| list['location'] == location && list['name'] == cat_breed }
    redirect_to root_path(kitties_list: @kitties_list)
  end
end
