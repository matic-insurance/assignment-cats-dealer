class CatsController < ApplicationController
  def index
    @grid = CatsGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  protected

  def grid_params
    params.fetch(:cats_grid, {}).permit!
  end
end
