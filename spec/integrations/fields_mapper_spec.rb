require 'rails_helper'
require 'integrations/mappers/fields_mapper'

describe FieldsMapper do
  it 'maps fields according to given mapping' do
    MAPPING = {
      name: 'breed'
    }.with_indifferent_access

    mapper = described_class.new(MAPPING)
    mapped = mapper.map_fields('name': 'expected')
    expect(mapped['name']).to be_nil
    expect(mapped['breed']).to eq 'expected'
  end

  it 'keeps fields for wich there is no mapping' do
    MAPPING = {
      name: 'breed'
    }.with_indifferent_access

    mapper = described_class.new(MAPPING)
    mapped = mapper.map_fields('name': 'expected', 'test': 'test')
    expect(mapped['name']).to be_nil
    expect(mapped['breed']).to eq 'expected'
    expect(mapped['test']).to eq 'test'
  end
end
