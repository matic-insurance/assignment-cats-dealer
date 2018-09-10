module Mappers
  class CatsUnlimited < Base
    MAPPING = {
    # Local     Remote
      breed:    'name',
      location: 'location',
      cost:     'price',
      image:    'image'
    }.freeze

    ADAPTER = ->(raw_data) { JSON.parse(raw_data) }
  end
end
