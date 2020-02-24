require 'rails_helper'

describe ShopParsers::Xml do
  context 'when parse xml' do
    let(:expected_result) { [{test: 'my'}] }
    let(:data) { expected_result.to_xml(root: :root) }

    it 'parsed xml is correct' do
      expect(described_class.parse(data)[:root]).to eq expected_result
    end
  end
end
