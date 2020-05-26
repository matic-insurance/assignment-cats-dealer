class Item < ActiveRecord::Base
  belongs_to :store
  belongs_to :city
  belongs_to :breed

  monetize :price_cents, allow_nil: true

  scope :active, -> { where(active: true) }
  scope :archived, -> { where(active: false) }
  scope :cats, -> { where(type: 'cat') }
end
