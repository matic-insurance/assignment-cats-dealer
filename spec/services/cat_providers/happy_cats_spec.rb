require 'rails_helper'

describe CatsProviders::HappyCats do
  subject { described_class.new(SearchRequest.new(cat_type: 'Bengal', user_location: 'Odessa')) }

  it { is_expected.to respond_to(:fetch_deals) }
  it { is_expected.to respond_to(:deals) }
end
