# frozen_string_literal: true

require 'rails_helper'

describe Shops::CatsUnlimitedApi do
  describe '#cat_list' do
    let(:instance) { described_class.new }
    let(:result) { instance.cat_list }

    it 'retrieve list of all cats', vcr: 'cats_unlimited' do
      expect(result.size).to eq(11)
      expect(result.sample).to be_a(Shops::Cat)
    end

    context 'when response is in the wrong format', vcr: 'happy_cats' do
      before { allow(instance).to receive(:url).and_return('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml') }

      it 'raises an error' do
        expect { result }.to raise_error(JSON::ParserError)
      end
    end
  end
end
