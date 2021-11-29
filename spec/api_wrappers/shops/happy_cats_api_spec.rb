# frozen_string_literal: true

require 'rails_helper'

describe Shops::HappyCatsApi do
  describe '#cat_list' do
    it 'retrieve list of all cats', vcr: 'happy_cats' do
      result = described_class.new.cat_list
      expect(result.size).to eq(10)
      expect(result.sample).to be_a(Shops::Cat)
    end

    # TODO: test errors
  end
end
