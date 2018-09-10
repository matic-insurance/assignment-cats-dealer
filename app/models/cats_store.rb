class CatsStore < ApplicationRecord
  scope :cats_list, ->(name, location) { where('name = ? and location = ?', name, location) }
end
