require 'rails_helper'

describe CatsAggregator do
  describe '#call' do
    context 'successful case' do
      before do
        described_class::SOURCES.each do |source|
          allow_any_instance_of(source).to receive(:data).and_return([build(:cat)])
        end
      end

      it "adds #{described_class::SOURCES.count} new cats to the database" do
        expect { subject.call }.to \
          change { Cat.count }.from(0).to(described_class::SOURCES.count)
      end
    end

    context 'problematic cases' do
      let!(:cat) { create :cat }

      before do
        # Duplicate cat
        allow_any_instance_of(described_class::SOURCES.first).to \
          receive(:data).and_return([cat])

        # Empty result
        allow_any_instance_of(described_class::SOURCES.second).to \
          receive(:data).and_return([])
      end

      it "doesn't duplicate cats" do
        subject.call

        expect(Cat.count).to eq(1)
      end
    end
  end
end
