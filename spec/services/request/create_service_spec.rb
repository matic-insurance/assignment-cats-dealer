require 'rails_helper'

describe Requests::CreateService do
  context 'params with errors' do
    let(:errors) { { some_key: [Faker::String.random(length: 4)] } }
    let(:response) do
      {
        errors: errors,
        locations: Cats::ListContract::LOCATIONS,
        cat_types: Cats::ListContract::CAT_TYPES
      }
    end

    subject { described_class.(errors: errors) }

    it 'returns data for form generation' do
      expect(subject.data).to eq(response)
    end
  end

  context 'params without errors' do
    let(:response) do
      {
        errors: {},
        locations: Cats::ListContract::LOCATIONS,
        cat_types: Cats::ListContract::CAT_TYPES
      }
    end

    subject { described_class.({}) }

    it 'returns data for form generation' do
      expect(subject.data).to eq(response)
    end
  end
end
