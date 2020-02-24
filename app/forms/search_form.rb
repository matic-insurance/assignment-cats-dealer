class SearchForm
  include ActiveModel::Model

  CATS_TYPE_OPTIONS = [
    'bengal', 'abyssin', 'persian', 'american curl', 'british shorthair',
    'devon rex', 'maine coon', 'sphynx', 'siamese'
  ].freeze

  LOCATION_OPTIONS = %w[lviv kiev kharkiv odessa].freeze

  attr_accessor :cats_type, :user_location

  validates_inclusion_of :cats_type, in: CATS_TYPE_OPTIONS
  validates_inclusion_of :user_location, in: LOCATION_OPTIONS

  def persisted?
    false
  end
end
