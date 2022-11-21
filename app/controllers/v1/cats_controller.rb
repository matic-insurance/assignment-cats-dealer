# frozen_string_literal: true

module V1
  class CatsController < ApplicationController
    def index
      render json: CatsFilter.new(params).result
    end
  end
end
