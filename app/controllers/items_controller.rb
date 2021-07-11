# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    result = Cats::Find.call(request_params)

    render json: result.items.to_json
  end

  private

  def request_params
    params.permit(:breed, :location)
  end
end
