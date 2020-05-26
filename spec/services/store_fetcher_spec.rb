require 'rails_helper'

RSpec.describe Services::StoreFetcher do
  describe '#call' do
    subject(:call_service) do
      described_class.new(store).call
    end

    describe 'when store with XML response' do
      let(:store) { Fabricate(:store_with_xml_response) }

      context 'with empty XML' do
        it 'adds no new items' do
          xml = ''
          allow(::RestClient).to receive(:get).and_return(xml)

          expect { call_service }.not_to change(Item, :count)
        end
      end

      context 'with wrong root keys' do
        it 'raises error' do
          xml = File.open('spec/data_samples/xml_samples/wrong_keys.xml')
          allow(::RestClient).to receive(:get).and_return(xml)

          expect { call_service }.to raise_error('wrong keys in response')
        end
      end

      context 'with all legit keys' do
        it 'adds 2 new items' do
          xml = File.open('spec/data_samples/xml_samples/legit_cats.xml')
          allow(::RestClient).to receive(:get).and_return(xml)

          expect { call_service }.to change(Item, :count).from(0).to(2)
        end
      end
    end

    describe 'when store with JSON response' do
      let(:store) { Fabricate(:store_with_json_response) }

      context 'with empty JSON' do
        it 'adds no new items' do
          json = ''
          allow(::RestClient).to receive(:get).and_return(json)

          expect { call_service }.not_to change(Item, :count)
        end
      end

      context 'with valid JSON with correct keys' do
        let(:json) { File.open('spec/data_samples/json_samples/legit_cats.json') }

        it 'adds 2 new items' do
          allow(::RestClient).to receive(:get).and_return(json)

          expect { call_service }.to change(Item, :count).from(0).to(2)
        end

        it 'adds 1 new breed' do
          allow(::RestClient).to receive(:get).and_return(json)

          expect { call_service }.to change(Breed, :count).from(0).to(1)
        end

        it 'adds 1 new city' do
          allow(::RestClient).to receive(:get).and_return(json)

          expect { call_service }.to change(City, :count).from(0).to(1)
        end
      end
    end
  end
end
