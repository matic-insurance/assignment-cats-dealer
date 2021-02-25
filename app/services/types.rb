module Types
  include Dry::Types()

  NAMES = %w[
    Abyssin American\ Curl Bengal Bobtail British\ Shorthair
    Devon\ Rex Grumpy Maine\ Coon Persian Siamese Sphynx
  ].freeze

  LOCATIONS = %w[Kharkiv Kyiv Lviv Odessa].freeze

  Name     = Types::String.enum(*NAMES)
  Location = Types::String.enum(*LOCATIONS)
  Price    = Types::Coercible::Integer.constrained(gt: 0)
  Image    = Types::String.constrained(format: /^https:/)
end
