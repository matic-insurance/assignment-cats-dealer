class CatName < ApplicationRecord
  validates_uniqueness_of :name
end
