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

  def self.apply_field_mappings!(deals)
    deals.each_with_object([]) do |deal, brand_new_deals|
      brand_new_deals << build_deal(deal)
      brand_new_deals
    end
  end

  def self.build_deal(current_deal)
    current_deal.keys.each_with_object({}) do |deal_key, deal|
      deal[field_name_mappings[deal_key.to_sym]] = current_deal[deal_key]
      deal
    end
  end
end
