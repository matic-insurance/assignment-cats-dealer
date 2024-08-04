# frozen_string_literal: true

class CatFinderService
  ADAPTORS = [
    CatFinderAdaptors::CatsUnlimitedAdaptor,
    CatFinderAdaptors::HappyCatsAdaptor
  ].freeze

  def self.call(location, cat_type)
    new(location, cat_type).call
  end

  def initialize(location, cat_type)
    @location = location
    @cat_type = cat_type
  end

  def call
    cats_data = fetch_all_cats_data
    raise NoDataAvailableError, 'No data available from any source' if cats_data.empty?

    filtered_cats = filter_cats(cats_data)
    find_all_best_matches(filtered_cats)
  end

  private

  def fetch_all_cats_data
    ADAPTORS.flat_map(&:fetch_data)
  end

  def filter_cats(cats_data)
    cats_data.select do |cat|
      cat['location'] == @location && cat['cat_type'] == @cat_type
    end
  end

  def find_all_best_matches(cats)
    return [] if cats.empty?

    min_price = cats.min_by { |cat| cat['price'] }['price']
    best_matches = cats.select { |cat| cat['price'] == min_price }

    best_matches.uniq { |cat| cat['image'] }
  end
end
