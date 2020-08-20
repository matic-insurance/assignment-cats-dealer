module CatsDealer
  class BestPrice
    SHOPS = [CatsDealer::Shops::HappyCats, CatsDealer::Shops::CatsUnlimited].freeze
    attr_accessor :all_cats

    def initialize
      @all_cats = SHOPS.map { |shop| shop.new.get_pretty_cats }.flatten.uniq
    end

    def get_cats_breeds
      all_cats.map{|cat| cat[:breed]}.uniq
    end

    def get_cats_locations
      all_cats.map{|cat| cat[:location]}.uniq
    end

    def get_best_price_cat(breed, location)
      filter_cats(breed, location).sort_by { |cat| cat[:price].to_f }
    end

    private

    def filter_cats(breed, location)
      all_cats.select { |cat| cat[:breed] == breed && cat[:location] == location }
    end
  end
end
