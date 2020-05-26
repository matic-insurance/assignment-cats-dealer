class Store < ActiveRecord::Base
  has_many :items, dependent: :destroy

  DEFAULT_CURRENCY = 'uah'.freeze

  DEFAULT_XML_MAPPING = {
    list_name: :cats,
    item_name: :cat,
    item_fields: {
      breed: :title,
      price: :cost,
      city: :location,
      img_url: :img
    }
  }.freeze

  DEFAULT_JSON_MAPPING = {
    list_name: nil,
    item_name: nil,
    item_fields: {
      breed: :name,
      price: :price,
      city: :location,
      img_url: :image
    }
  }.freeze

  def fetch_and_store_items
    ItemsRefresher
  end
end
