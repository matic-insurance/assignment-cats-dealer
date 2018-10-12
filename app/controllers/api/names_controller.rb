module Api
  class NamesController < BaseController
    def index
      render json: Cat.names
    end
  end
end
