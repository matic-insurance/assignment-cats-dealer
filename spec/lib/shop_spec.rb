require 'rails_helper'

describe Shop do
  context 'when returns filtered shops items' do
    subject(:shop_subject) { described_class.new(shop, filter_params) }

    let(:correct_result_item) { {name: 'boo', location: 'lviv'} }
    let(:additional_item) { {name: 'boo2', location: 'kyiv'} }
    let(:response_to_filter) { [correct_result_item, additional_item] }

    let(:shop) do
      Class.new do
        def self.url
          'url'
        end

        def self.client
          Class.new do
            def self.get(_url)
              'response'
            end
          end
        end

        def self.prepare_response(_response)
          [
            {name: 'boo', location: 'lviv'}, # correct_result_item
            {name: 'boo2', location: 'kyiv'} # additional_item
          ]
        end
      end
    end

    let(:filter_params) { {user_location: 'lviv', cats_type: 'boo'} }

    it 'returns correct_result_item' do
      expect(shop_subject.items).to eq [correct_result_item]
    end
  end
end
