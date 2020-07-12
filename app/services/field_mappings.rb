module FieldMapings
  def self.field_name_mappings
    {
      cost: :price,
      price: :price,
      img: :image_src,
      image: :image_src,
      title: :breed,
      name: :breed,
      location: :location
    }
  end
end
