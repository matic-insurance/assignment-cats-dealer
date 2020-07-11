require 'rails_helper'

describe SearchRequest do
  subject(:search_request) { described_class.new(cat_type: 'Abyssin', user_location: 'Lviv') }

  it { is_expected.to have_attributes(cat_type: 'Abyssin', user_location: 'Lviv') }
end
