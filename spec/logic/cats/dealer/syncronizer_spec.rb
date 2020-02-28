require 'rails_helper'

describe ::Cats::Dealer::Syncronizer do
  subject { described_class.sync_cats }

  around(:each) do |example|
    VCR.use_cassette(cassette, &example)
  end

  let(:cassette) { 'shops_api' }

  context 'when there is no data cached' do
    it 'fetches the data from remote shops' do
      expect_any_instance_of(CatsUnlimitedAdapter).to receive(:cats)
      expect_any_instance_of(HappyCatsAdapter).to receive(:cats)

      subject
    end

    it 'caches the data to database' do
      expect{ subject }.to change(Cat, :count).by(21)
    end
  end

  context 'when data needs to be updated' do
    let(:cassette) { 'shops_api_refresh_call' }

    it 'updates cached data' do
      travel_to 6.minutes.ago

      described_class.sync_cats

      travel_back

      target_a = Cat.first.updated_at

      subject

      target_b = Cat.first.updated_at

      expect(target_a).not_to eq(target_b)
    end
  end

  context 'when data do not need to be updated' do
    it 'should stop operation if data is fresh enough' do
      subject

      expect(Cat.count).to eq 21

      expect{ subject }.not_to change(Cat.first, :updated_at)

      subject
    end
  end
end
