class Breed < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
