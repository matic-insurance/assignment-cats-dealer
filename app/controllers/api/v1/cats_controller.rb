module Api::V1
  class CatsController < ApplicationController
    def index
      response = RestClient.get('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json')
      cats_list = JSON.parse(response.body)

      cats_list =
        cats_list.select do |cat|
          cat['location'] == params[:location] && cat['name'] == params[:cat_type]
        end

      render json: cats_list
    end
  end
end
