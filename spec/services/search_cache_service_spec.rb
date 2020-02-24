require 'rails_helper'

describe SearchCacheService do
  context 'when cache wrapper' do
    subject(:search_cache_service) { described_class.new(search_id) }

    let(:search_id) { SecureRandom.uuid }
    let(:raw_value) { 'raw_cache_value' }
    let(:cache_key_value) do
      "#{Rails.configuration.search['search_cache']['key_prefix']}#{search_id}"
    end
    let(:prepared_value) do
      described_class.generate_value(raw_value)
    end
    let(:ttl) { 3.minutes }

    context 'when write' do
      before do
        allow(Rails.cache).to receive(:write)
      end

      it 'calls Rails.cache.write with correct params' do
        search_cache_service.write(raw_value, ttl)
        expect(Rails.cache).to have_received(:write)
          .with(cache_key_value, prepared_value, expires_in: ttl)
      end
    end

    context 'when read' do
      before do
        allow(Rails.cache).to receive(:read)
      end

      it 'calls Rails.cache.read with correct params' do
        search_cache_service.read
        expect(Rails.cache).to have_received(:read)
          .with(cache_key_value)
      end

      it 'returns nil' do
        allow(Rails.cache).to receive(:read)
          .with(cache_key_value).and_return(nil)

        expect(search_cache_service.read).to be_nil
      end

      it 'returns raw_value' do
        allow(Rails.cache).to receive(:read)
          .with(cache_key_value).and_return(prepared_value)

        expect(search_cache_service.read).to eq raw_value
      end
    end
  end
end
