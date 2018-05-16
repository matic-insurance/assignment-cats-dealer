require 'rails_helper'
require 'integrations/enrichers/shop_info_enricher'

describe ShopInfoEnricher do
  it 'enriches given hash with shop name' do
    enricher = described_class.new('ShopName')
    expect(enricher.enrich({})['shop']).to eq 'ShopName'
  end
end
