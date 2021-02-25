class FilteredCatsResult < Dry::Struct
  attribute :best_price, Types::Price.optional
  attribute :cats_list,  Types::Array.of(Cat)
end
