module Mappers
  class HappyCats < Base
    MAPPING = {
    # Local     Remote
      breed:    'title',
      location: 'location',
      cost:     'cost',
      image:    'img'
    }.freeze

    ADAPTER = ->(raw_data) { Hash.from_xml(raw_data)['cats']['cat'] }
  end
end
