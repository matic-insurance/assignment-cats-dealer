require 'dry-initializer'
require 'dry-types'

class BestOffer
  extend Dry::Initializer

  option :name,     Types::Name
  option :location, Types::Location

  def call
    FilteredCatsResult.new(cats_list: filtered_cats, best_price: best_price)
  end

  private

  def all_cats
    AllCats.new.call
  end

  def filtered_cats
    @filtered_cats ||= all_cats.grep(->(cat) { cat.name == name && cat.location == location })
  end

  def best_price
    BestPrice.new(cats_list: filtered_cats).call
  end
end
