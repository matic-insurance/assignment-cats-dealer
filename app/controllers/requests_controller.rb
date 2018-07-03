class RequestsController < ApplicationController
  def new
    @cities = %w[Lviv Odessa Kiev]
    @cat_types = %w[Bengal Abyssin Persian]
  end

  def create
    response = HTTPRequestService::BaseRequest.new(BaseAPIURL::JSON_URL)

    cat_type = params[:cats_type]
    location = params[:user_location]
    parameters = {cats_list: response.from_json, cat_type: cat_type, location: location}

    redirect_to result_request_path(parameters)
  end

  def result
    result = CatsAnalyzerService.new params[:cats_list]
    @cats_list = result.all(params[:cat_type], params[:location])
  end
end
