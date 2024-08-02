class CatAdapter
  def initialize(shop_name:)
    @shop_name = shop_name
  end

  def adapt(response)
    response.map { |item| transform_item(item) }
  end

  private

  def transform_item(item)
    mapped_item = mapping.transform_values do |remote_attr|
      item[remote_attr]
    end

    mapped_item[:shop_name] = @shop_name
    mapped_item
  end

  def mapping
    raise NotImplementedError, "This #{self.class} cannot respond to: #{__method__}"
  end
end
