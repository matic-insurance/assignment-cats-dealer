class CatsController < ApplicationController
  helper_method :cats_names, :locations

  def index
    return unless cat_params[:name] && cat_params[:location]

    @result = BestOffer.new(name: cat_params[:name], location: cat_params[:location]).call
  end

  private

  def cat_params
    params.permit(:name, :location)
  end

  def cats_names
    Types::NAMES
  end

  def locations
    Types::LOCATIONS
  end
end
