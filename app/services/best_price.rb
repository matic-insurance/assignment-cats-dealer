require 'dry-initializer'
require 'dry-types'

class BestPrice
  extend Dry::Initializer

  option :cats_list, Types::Array.of(Cat)

  def call
    return unless cats_list.any?

    cats_list.min_by(&:price).price
  end
end
