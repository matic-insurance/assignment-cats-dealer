# frozen_string_literal: true

# Module to rescue from known exceptions
module ErrorRescues
  extend ActiveSupport::Concern

  included do
    rescue_from ExtraParametersError, with: :rescue_from_extra_parameters

    private

    def rescue_from_extra_parameters(error)
      render json: { status: :error, message: error.message }, status: :bad_request
    end
  end
end
