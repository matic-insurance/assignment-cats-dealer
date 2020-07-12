require 'rails_helper'

describe SearchRequest do
  subject(:search_request) { described_class.new(breed: 'Abyssin', user_location: 'Lviv') }

  it { is_expected.to have_attributes(breed: 'Abyssin', user_location: 'Lviv') }
  it { is_expected.to respond_to(:breed) }
  it { is_expected.to respond_to(:user_location) }
end
