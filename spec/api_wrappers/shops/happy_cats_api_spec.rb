# frozen_string_literal: true

require 'rails_helper'

describe Shops::HappyCatsApi do
  describe '#cat_list' do
    let(:instance) { described_class.new }
    let(:result) { instance.cat_list }

    it 'retrieve list of all cats', vcr: 'happy_cats' do
      expect(result.size).to eq(10)
      expect(result.sample).to be_a(Shops::Cat)
    end

    context 'when response is in the wrong format', vcr: 'cats_unlimited' do
      before { allow(instance).to receive(:url).and_return('https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json') }

      it 'raises an error' do
        expect { result }.to raise_error(REXML::ParseException)
      end
    end
  end
end
