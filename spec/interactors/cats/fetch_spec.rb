require 'rails_helper'

describe Cats::Fetch do
  subject(:fetching) { Cats::Fetch.call }

  context 'when all providers responds normally' do
    let(:cats_unlimited_list) { ['stub_cats_unlimited'] }

    before do
      allow_any_instance_of(::Cats::Providers::CatsUnlimitedService)
        .to receive(:data).and_return(cats_unlimited_list)
    end

    it 'succeeds with cats list' do
      expect(fetching.success?).to eq true
      expect(fetching.list).to eq cats_unlimited_list
    end
  end

  context 'when one of providers failure' do
    before do
      allow_any_instance_of(::Cats::Providers::CatsUnlimitedService)
        .to receive(:data).and_raise(ProviderUnavailableError, 'Provider stub')
    end

    it 'failure with expected error' do
      expect(fetching.success?).to eq false
      expect(fetching.error)
        .to eq 'Service "Provider stub" is unavailable. Try again later'
    end
  end
end
