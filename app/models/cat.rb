class Cat < ApplicationRecord
  include Relations::CatBreed, Relations::CatLocation
  include Checksumable

  has_checksum

  validates :cost, presence: true, numericality: { only_integer: true }

  private

  def checksum_base
    breed.name + location.name + cost.to_s + image
  end
end
