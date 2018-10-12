class Cat < ApplicationRecord
  validates :name, presence: true
  validates :location, presence: true
  validates :price, presence: true

  def self.locations
    Cats::GetValues.new("location").call
  end

  def self.names
    Cats::GetValues.new("name").call
  end
end
