class RequestsController < ApplicationController
  def new
    @result = Requests::CreateService.(parameters)
  end
end
