# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cat, type: :model do
  subject(:result) { described_class.new(payload) }

  let(:default_payload) do
    {
      type: 'Cat1',
      price: 40.0,
      location: 'Lviv',
      image: 'img_url',
      shop_name: 'Shop1'
    }
  end

  context 'with well defined payload' do
    let(:payload) { default_payload }

    it { expect { result }.not_to raise_error }
  end

  %i[type price location image shop_name].each do |field|
    context "with required filed #{field} is missing" do
      let(:payload) { default_payload.except(field) }

      it { expect { result }.to raise_error(Dry::Struct::Error, /:#{field} is missing/) }
    end
  end
end
