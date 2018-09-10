require 'rails_helper'

describe Cat do
  describe 'validations' do
    subject { create :cat }

    it { should validate_presence_of(:breed) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost) }
    it { should validate_uniqueness_of(:checksum) }
  end

  describe 'relations with associated records' do
    context 'when records with provided names already exist' do
      let!(:breed)    { create :breed }
      let!(:location) { create :location }
      let!(:cat)      { build :cat }

      it 'finds existing associations' do
        cat.breed = breed.name
        cat.location = location.name
        cat.save

        expect(cat.location_id).to eq(location.id)
        expect(cat.breed_id).to eq(breed.id)
      end
    end

    context 'when provided names are new' do
      let(:cat) { build :cat }

      it 'creates new associated records' do
        cat.breed = 'foo'
        cat.location = 'bar'
        cat.save

        expect(cat.breed.name).to eq('foo')
        expect(cat.location.name).to eq('bar')

        expect(cat.breed).not_to be_a_new(Breed)
        expect(cat.location).not_to be_a_new(Location)
      end
    end
  end

  describe 'checksum' do
    let(:cat) { create :cat }

    it 'creates checksum basing on breed.name, location.name, cost & image' do
      expect(Digest::MD5.hexdigest(cat.send(:checksum_base))).to eq(cat.checksum)
    end
  end
end
