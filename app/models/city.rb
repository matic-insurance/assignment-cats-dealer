class City < ApplicationRecord
  validates_uniqueness_of :location
end
