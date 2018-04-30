class Cat < ApplicationRecord
  def self.locations
    distinct.pluck(:location)
  end

  def self.breeds
    distinct.pluck(:breed)
  end
end
