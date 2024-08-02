require 'rails_helper'

describe Shops::FindCheaper::Organize do
  let(:interactors) do
    [Shops::FindCheaper::FetchAllRecords, Shops::FindCheaper::FindCheapestRecord]
  end

  describe '.organize' do
    it 'organizes FetchAllRecords and FindCheapestRecord' do
      expect(described_class.organized).to eq(interactors)
    end
  end
end
