# frozen_string_literal: true

require 'rails_helper'

describe Cats::Record do
  it 'convert price to int' do
    record = described_class.new(name: 'Maine Coon', price: '42', location: 'Dnipro')

    expect(record.price).to eq(42)
  end
end
