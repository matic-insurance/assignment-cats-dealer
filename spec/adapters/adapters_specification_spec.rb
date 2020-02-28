require 'rails_helper'

describe 'Adapters Specification' do
  adapters = [
    CatsUnlimitedAdapter,
    HappyCatsAdapter
  ]

  around(:each) do |example|
    VCR.use_cassette(cassette, &example)
  end

  adapters.each do |adapter_class|
    context "#{adapter_class} valid by specification" do
      let(:adapter)  { adapter_class.new }
      let(:cassette) { "#{adapter_class.to_s.underscore}_api" }

      describe '#cats' do
        subject { adapter.cats }

        it 'returns a valid response representation' do
          expect(subject).to be_an(Array)

          subject.each do |object|
            expect(object).to be_instance_of(BaseAdapter::RemoteCat)
          end
        end
      end
    end
  end
end
