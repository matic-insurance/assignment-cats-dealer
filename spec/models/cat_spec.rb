require 'rails_helper'

describe Cat, type: :model do
  subject(:cat_class) { described_class }

  before do
    create_list(:cat, 5)
    create(:cat, :purebred, :in_odessa)
  end

  describe '.locations' do
    it 'returns all unique locations for available cats' do
      expected_locations = %w[Lviv Odessa]
      expect(cat_class.locations).to match_array(expected_locations)
    end
  end

  describe '.breeds' do
    it 'returns all unique breeds for available cats' do
      expected_breeds = %w[Typical Pedigree]
      expect(cat_class.breeds).to match_array(expected_breeds)
    end
  end
end
