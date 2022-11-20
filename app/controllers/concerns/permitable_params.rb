# frozen_string_literal: true

module PermitableParams
  extend ActiveSupport::Concern

  PERMITABLE_PARAMS = %i[location type].freeze
  PARAMS_TO_SKIP = %i[action controller].freeze

  included do
    def params
      raise ExtraParametersError if extra_params.present?

      request.parameters.symbolize_keys.slice(*PERMITABLE_PARAMS)
    end

    private

    def extra_params
      request.parameters.symbolize_keys.except(*PARAMS_TO_SKIP).keys - PERMITABLE_PARAMS
    end
  end
end
