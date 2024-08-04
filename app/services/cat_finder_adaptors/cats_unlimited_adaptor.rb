# frozen_string_literal: true

module CatFinderAdaptors
  class CatsUnlimitedAdaptor < BaseAdaptor
    def self.fetch_data
      get_data(ENV.fetch('CATS_UNLIMITED_URL'), 'json')
    end
  end
end
