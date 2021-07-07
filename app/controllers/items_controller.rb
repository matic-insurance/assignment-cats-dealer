class ItemsController < ApplicationController
  def show
    render json: items.to_json
  end

  private

  def items
    []
  end
end
