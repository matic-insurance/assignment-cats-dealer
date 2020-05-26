class Item < ActiveRecord::Base
  belongs_to :store
  belongs_to :city
  belongs_to :breed

  monetize :price_cents, allow_nil: true
end
