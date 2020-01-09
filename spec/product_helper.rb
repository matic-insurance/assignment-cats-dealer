module ProductHelper
  def check_item_attribute_type(item, attribute, type)
    expect(item[attribute]).to be_a(type)
  end

  def check_item_attribute_value(item, attribute, value)
    expect(item[attribute]).to eq(value)
  end
end