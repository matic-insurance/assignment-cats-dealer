require 'rails_helper'

describe Sources::HappyCats do
  describe '#data' do
    let(:raw_response) { File.read('spec/support/fixtures/happy_cats/success.xml') }
    let(:response) { Hash.from_xml(raw_response)['cats']['cat'] }

    before do
      stub_request(:get, described_class::SOURCE_URL)
        .to_return(status: 200, body: raw_response)
    end

    context "requests #{described_class::SOURCE_URL} and gets result" do
      it 'properly parses and assigns data' do
        subject.data.each_with_index do |cat, idx|
          expect(cat.instance_variable_get(:@breed)).to eq(response[idx]['title'])
          expect(cat.instance_variable_get(:@location)).to eq(response[idx]['location'])
          expect(cat.cost).to eq(response[idx]['cost'].to_i)
          expect(cat.image).to eq(response[idx]['img'])
        end
      end
    end
  end
end
