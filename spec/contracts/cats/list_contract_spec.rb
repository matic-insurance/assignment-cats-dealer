require 'rails_helper'

describe Cats::ListContract do
  context 'valid data' do
    let(:valid_data) do
      {
        cats_type: described_class::CAT_TYPES.sample,
        user_location: described_class::LOCATIONS.sample
      }
    end

    subject { described_class.new.(valid_data) }

    it 'returns success' do
      expect(subject.success?).to be_truthy
    end
  end

  context 'invalid data' do
    context 'without required attributes' do
      subject { described_class.new.({}) }

      it 'returns success' do
        expect(subject.failure?).to be_truthy

        expect(subject.errors.to_h.keys).to match_array(%i[cats_type user_location])
      end
    end

    context 'not included attributes' do
      let(:invalid_data) do
        {
          cats_type: Faker::String.random(length: 4),
          user_location: Faker::String.random(length: 4)
        }
      end

      subject { described_class.new.(invalid_data) }

      it 'returns success' do
        expect(subject.failure?).to be_truthy

        expect(subject.errors.to_h.keys).to match_array(%i[cats_type user_location])
      end
    end
  end
end
