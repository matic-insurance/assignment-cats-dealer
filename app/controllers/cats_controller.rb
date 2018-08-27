class CatsController < ApplicationController
  def index
    @cats = Cat.filter(cat_params)
  end

  private

  def cat_params
    params.permit(:name, :location)
  end
end
