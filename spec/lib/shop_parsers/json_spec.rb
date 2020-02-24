require 'rails_helper'

describe ShopParsers::Json do
  context 'when parse json' do
    let(:expected_result) { [{test: 'my'}] }
    let(:data) { JSON.generate(expected_result) }

    it 'parsed json is correct' do
      expect(described_class.parse(data)).to eq expected_result
    end
  end
end
