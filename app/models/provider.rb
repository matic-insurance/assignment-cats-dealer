class Provider < ApplicationRecord
  has_many :cats
  has_and_belongs_to_many :locations

  def self.provider_deals(provider_name)
    select(:'cats.id', :breed, :price, :location, :image_src).joins(:cats).where(name: provider_name)
  end
end
