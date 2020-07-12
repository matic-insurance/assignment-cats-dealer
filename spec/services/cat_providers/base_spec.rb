require 'rails_helper'
describe CatsProviders::Base do
  subject(:cat_provider) { described_class.new(breed: 'Sphynx', user_location: 'Odessa') }

  it { is_expected.to respond_to(:fetch_deals) }
  it { is_expected.to respond_to(:deals) }
end
