require 'rails_helper'

describe Cats::SearchHelper, type: :helper do
  describe '#picture_for' do
    let(:cat) { build(:cat) }

    it 'returns the img tag with included cat picture' do
      img_tag = picture_for(cat)

      expect(img_tag).to include('img-thumbnail')
      expect(img_tag).to include(cat.picture_url)
    end
  end

  describe '#available_locations' do
    it 'delegates to Cat.locations' do
      allow(Cat).to receive(:locations).and_return(true)

      expect(available_locations).to be_truthy
      expect(Cat).to have_received(:locations)
    end
  end

  describe '#available_breeds' do
    it 'delegates to Cat.breeds' do
      allow(Cat).to receive(:breeds).and_return(true)

      expect(available_breeds).to be_truthy
      expect(Cat).to have_received(:breeds)
    end
  end
end
