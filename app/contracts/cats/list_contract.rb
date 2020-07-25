module Cats
  class ListContract < ApplicationContract
    CAT_TYPES = [
      'Abyssin',
      'American curl',
      'Bengal',
      'British shorthair',
      'Devon rex',
      'Maine coon',
      'Siamese',
      'Sphynx',
      'Persian'
    ].freeze

    LOCATIONS = %w[
      Kharkiv
      Kyiv
      Lviv
      Odessa
    ].freeze

    params do
      required(:cats_type).value(included_in?: CAT_TYPES)
      required(:user_location).value(included_in?: LOCATIONS)
    end
  end
end
