# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    items = Cats::Filter.new(
      breed: params['breed'],
      location: params['location'],
    ).call

    render json: items.to_json
  end
end
