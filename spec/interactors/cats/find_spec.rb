require 'rails_helper'

RSpec.describe Cats::Find do
  it 'organizes interactors Cats::Fetch, Cats::Filter' do
    expect(described_class.organized).
      to match_array([Cats::Fetch, Cats::Filter])
  end
end
