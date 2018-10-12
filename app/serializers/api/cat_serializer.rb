module Api
  class CatSerializer < ActiveModel::Serializer
    attributes :name, :price, :location, :image
  end
end
