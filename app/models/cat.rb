class Cat < ApplicationRecord
  belongs_to :provider, optional: true

  def self.pussies(provider_name)
    where(provider_id: Provider.find_by(name: provider_name))add
  end
end
