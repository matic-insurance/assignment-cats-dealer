class CatsController < ApplicationController
  def index
    @cats = Cat.filter(cat_params, Constants::SKIP_FILTER_VALUE)
  end

  private

  def cat_params
    params.permit(:name, :location)
  end
end
