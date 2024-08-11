# frozen_string_literal: true

# CatService is responsible for coordinating the fetching and processing of cat data
# from multiple sources. It aggregates data from various fetchers and provides
# utility methods to interact with the collected data.
#
# The service can fetch all available cats and find the best deal (i.e., the cat with the lowest price).
#
# Example usage:
#   fetchers = [CatsUnlimitedFetcher.new, HappyCatsFetcher.new]
#   service = CatService.new(fetchers)
#   all_cats = service.fetch_all_cats
#   best_deal = service.find_best_deal
class CatService
  def initialize(fetchers)
    @fetchers = fetchers
  end

  def fetch_all_cats
    fetchers.each_with_object([]) do |fetcher, cats|
      cats.concat(fetcher.fetch)
    end
  end

  def find_best_deal
    fetch_all_cats.min_by(&:price)
  end

  private

  attr_reader :fetchers
end
