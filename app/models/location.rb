class Location < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
