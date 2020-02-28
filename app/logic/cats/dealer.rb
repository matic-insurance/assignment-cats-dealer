# frozen_string_literal: true

module Cats
  module Dealer
    BREEDS    = %w[Bengal Abyssin Persian].freeze
    LOCATIONS = %w[Lviv Kiev Odessa].freeze

    # rubocop:disable all
    extend self
    # rubocop:enable all

    delegate :sync_cats, to: Syncronizer
    delegate :shops,     to: ShopsManager

    def self.find_cats(location:, breed:)
      ::Cat.where(location: location, breed: breed)
    end
  end
end
