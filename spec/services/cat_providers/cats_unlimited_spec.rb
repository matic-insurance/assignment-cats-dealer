require 'rails_helper'

describe CatsProviders::CatsUnlimited do
  subject(:provider) { described_class.new(SearchRequest.new(breed: 'Bengal', user_location: 'Kyiv')) }

  it { is_expected.to respond_to(:fetch_deals) }
  it { is_expected.to respond_to(:deals) }

  describe '#fetch_deals' do
    specify { expect { provider.fetch_deals }.to change { provider.deals.present? }.to(true) }
    specify { expect { provider.fetch_deals }.to change { provider.deals.first }.to(hash_including('name' => 'Bengal', 'location' => 'Kyiv')) }
  end
end
