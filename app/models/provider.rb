class Provider < ApplicationRecord
  has_many :cats
  has_and_belongs_to_many :locations

  def self.provider_deals(provider_name)
    Cat.joins('INNER JOIN providers ON providers.id = cats.provider_id')
       .select(:breed, :price, :location, :image_src)
       .where(provider_id: find_by(name: provider_name))
  end
end
