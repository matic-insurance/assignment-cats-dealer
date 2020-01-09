class CatsController < ApplicationController
  def index
    @cats = Cat.where(request_id: params[:request_id])
  end
end
