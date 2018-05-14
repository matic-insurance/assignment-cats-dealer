require 'rails_helper'
require 'integrations/enrichers/shop_info_enricher'

describe ShopInfoEnricher do

  it 'should enrich given hash with shop name' do
    enricher = ShopInfoEnricher.new('ShopName')
    expect(enricher.enrich({})['shop']).to eq 'ShopName'
  end
end
