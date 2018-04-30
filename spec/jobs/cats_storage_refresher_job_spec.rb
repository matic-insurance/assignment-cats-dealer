require 'rails_helper'

describe CatsStorageRefresherJob do
  subject(:storage_refresher) { described_class.new }

  describe '#perform' do
    let(:new_cats) { build_list(:cat, 5) }

    before do
      create_list(:cat, 10)
      allow(storage_refresher).to receive(:fetch_new_records).and_return(new_cats)
    end

    it 'updated all cat offers with new records' do
      expect(Cat.count).to be_positive
      expect { storage_refresher.perform }.to change(Cat, :count).to(new_cats.count)
    end
  end

  describe '#delete_old_records' do
    before { create_list(:cat, 10) }

    it 'remove all cat records from DB' do
      expect { storage_refresher.send(:delete_old_records) }.to change(Cat, :count).to(0)
    end
  end

  describe '#fetch_new_records' do
    it 'retrieves new cat records from FetchService' do
      allow(CatsServices::FetchService).to receive(:all)

      storage_refresher.send(:fetch_new_records)
      expect(CatsServices::FetchService).to have_received(:all)
    end
  end
end
