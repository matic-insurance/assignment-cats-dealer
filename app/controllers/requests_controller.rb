# frozen_string_literal: true

class RequestsController < ApplicationController
  def new
    @breeds    = ::Cats::Dealer::BREEDS
    @locations = ::Cats::Dealer::LOCATIONS
  end

  def create
    ::Cats::Dealer.sync_cats

    redirect_to request_path(location: params[:location], breed: params[:breed])
  end

  def show
    @cats = ::Cats::Dealer.find_cats(location: params[:location], breed: params[:breed])

    @best_price = @cats.min_by(&:price).price if @cats.present?
  end
end
