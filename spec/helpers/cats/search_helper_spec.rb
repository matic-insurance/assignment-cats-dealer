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

  describe '#sort_by_price' do
    let(:unordered_cats) { build_list(:cat, 10) }

    it 'sorts passed cats in ascending order by price' do
      sorted_cats = sort_by_price(unordered_cats)

      expect(sorted_cats).to_not match(unordered_cats)
      expect(sorted_cats.first.price).to be < sorted_cats.last.price
    end

    context 'if \'ascending\' parameter is set to false' do
      it 'sorts passed cats in descending order' do
        sorted_cats = sort_by_price(unordered_cats, ascending: false)

        expect(sorted_cats).to_not match(unordered_cats)
        expect(sorted_cats.first.price).to be > sorted_cats.last.price
      end
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
