# frozen_string_literal: true

# The Cat struct represents a cat with attributes such as name, price, location, and image.
# It provides validation to ensure that all required attributes are present and correctly formatted.
#
# Example usage:
#   cat = Types::Cat.new('Siamese', 100.0, 'New York', 'http://example.com/siamese.jpg')
#   cat.to_h # => { name: 'Siamese', price: 100.0, location: 'New York', image: 'http://example.com/siamese.jpg' }
#
# Attributes:
# - name: The name of the cat (String)
# - price: The price of the cat (Float)
# - location: The location where the cat is available (String)
# - image: The URL of the cat's image (String)
#
# This struct raises an InvalidCatError if any of the required attributes are missing or blank.
module Types
  Cat = Struct.new(:name, :price, :location, :image) do
    def initialize(name, price, location, image)
      validate_presence!(name, 'Name')
      validate_presence!(price, 'Price')
      validate_presence!(location, 'Location')
      validate_presence!(image, 'Image')

      super(name, price, location, image)
    end

    def to_h
      {
        name:,
        price:,
        location:,
        image:
      }
    end

    private

    def validate_presence!(attribute, attribute_name)
      raise ::Errors::InvalidCatError, "#{attribute_name} is missing" if attribute.blank?
    end
  end
end
