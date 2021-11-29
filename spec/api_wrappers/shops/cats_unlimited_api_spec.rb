# frozen_string_literal: true

require 'rails_helper'

describe Shops::CatsUnlimitedApi do
  describe '#cat_list' do
    it 'retrieve list of all cats', vcr: 'cats_unlimited' do
      result = described_class.new.cat_list
      expect(result.size).to eq(11)
      expect(result.sample).to be_a(Shops::Cat)
    end

    # TODO: test errors
  end
end
