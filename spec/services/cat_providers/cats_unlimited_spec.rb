require 'rails_helper'

describe CatsProviders::CatsUnlimited do
  subject { described_class.new(SearchRequest.new(cat_type: 'Bengal', user_location: 'Kyiv')) }

  it { is_expected.to respond_to(:fetch_deals) }
  it { is_expected.to respond_to(:deals) }

  describe "#fetch_deals" do
    specify { expect { subject.fetch_deals }.to change { subject.deals.present? }.to(true) }
    specify { expect { subject.fetch_deals }.to change { subject.deals.first }.to(hash_including('name' => 'Bengal', 'location' => 'Kyiv')) }
  end

end
