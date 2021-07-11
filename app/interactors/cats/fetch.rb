module Cats
  class Fetch
    include Interactor
    AVAILABLE_STORES = [
      Cats::CatsUnlimitedAdapter,
      Cats::HappyCatsAdapter,
    ].freeze

    def call
      context.items = AVAILABLE_STORES.map(&:fetch_items).flatten
    end
  end
end
