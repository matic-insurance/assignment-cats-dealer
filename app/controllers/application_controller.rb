# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity
  rescue_from ArgumentError, with: :unprocessable_entity
  rescue_from NoDataAvailableError, with: :handle_no_data_available

  private

  def unprocessable_entity(exception)
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  def handle_no_data_available(exception)
    render json: { message: exception.message }, status: :service_unavailable
  end
end
