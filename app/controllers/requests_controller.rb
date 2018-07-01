class RequestsController < ApplicationController
  include Requests
  include Predicate

  def create
    json_response = BaseRequest.json_response
    xml_response = BaseRequest.xml_response
    result = json_response + xml_response

    caty_type = params[:caty_type]
    location = params[:user_location]

    redirect_to result_request_path(cats_list: result, cat_type: caty_type, location: location)
  end

  def result
    predicate = Predicate::Cats.new params[:cats_list]
    @cats_list = predicate.result_by(params[:location], params[:cat_type])
  end
end
