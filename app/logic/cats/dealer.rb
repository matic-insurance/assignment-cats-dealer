
module Cats
  module Dealer
    BREEDS    = %w(Bengal Abyssin Persian).freeze
    LOCATIONS = %w(Lviv Kiev Odessa).freeze

    extend self

    delegate :sync_cats, to: Syncronizer
    delegate :shops,     to: ShopsManager

    def self.find_cats(location:, breed:)
      ::Cat.where(location: location, breed: breed)
    end
  end
end
