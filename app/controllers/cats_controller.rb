# frozen_string_literal: true

class CatsController < ApplicationController
  def index
    render json: CatsFilter.new(params).result
  end
end
