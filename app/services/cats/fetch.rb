module Cats
  class Fetch
    AVAILABLE_STORES = [
      Cats::CatsUnlimitedAdapter,
      Cats::HappyCatsAdapter,
    ].freeze

    def call
      AVAILABLE_STORES.map(&:fetch_items).flatten
    end
  end
end
