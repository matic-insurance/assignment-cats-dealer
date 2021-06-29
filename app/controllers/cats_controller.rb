# frozen_string_literal: true

class CatsController < ApplicationController
  def index
    fetching = ::Cats::Fetch.call(filters: filter_params)
    return render(json: fetching.list) if fetching.success?

    render json: { error: fetching.error }, status: 503
  end

  private

  def filter_params
    params.permit(:cat_type, :location)
          .to_h
          .select { |_key, value| value.present? }
          .symbolize_keys
  end
end
