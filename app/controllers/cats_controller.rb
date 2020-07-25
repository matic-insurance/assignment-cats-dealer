class CatsController < ApplicationController
  def index
    @result = Cats::ListService.(parameters)

    redirect_to new_request_path(errors: @result.errors) unless @result.success?
  end
end
