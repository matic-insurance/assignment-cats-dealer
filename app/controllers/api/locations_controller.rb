module Api
  class LocationsController < BaseController
    def index
      render json: Cat.locations
    end
  end
end
