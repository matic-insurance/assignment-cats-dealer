# frozen_string_literal: true

class ProviderUnavailableError < ::StandardError
  def initialize(provider_name)
    super ::I18n.t('errors.provider_unavailable', name: provider_name)
  end
end
