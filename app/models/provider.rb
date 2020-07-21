class Provider < ApplicationRecord
  has_many :cats
  has_and_belongs_to_many :locations
end
