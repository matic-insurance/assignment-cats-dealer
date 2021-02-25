class Cat < Dry::Struct
  attribute :name,     Types::Name
  attribute :location, Types::Location
  attribute :price,    Types::Price
  attribute :image,    Types::Image
end
