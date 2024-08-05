# frozen_string_literal: true

module ErrorsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :standard_error
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
  end

  private

  def parameter_missing(exception)
    Rails.logger.error("ParameterMissing: #{exception.message}")

    render json: { error: exception.message }, status: :bad_request
  end

  def standard_error(exception)
    Rails.logger.error("StandardError: #{exception.message}")

    render json: { error: exception.message }, status: :internal_server_error
  end
end
