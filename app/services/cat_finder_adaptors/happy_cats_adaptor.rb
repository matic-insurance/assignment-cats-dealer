# frozen_string_literal: true

module CatFinderAdaptors
  class HappyCatsAdaptor < BaseAdaptor
    def self.fetch_data
      get_data(ENV.fetch('HAPPY_CATS_URL'), 'xml')
    end
  end
end
