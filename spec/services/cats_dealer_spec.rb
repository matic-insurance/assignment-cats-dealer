require 'rails_helper'

describe CatsDealer do
  it 'respond to get_deals method' do
    expect(described_class).to respond_to(:get_deals)
  end

  # context 'best deal' do
  #   subject {  }
  #   it { is_expected.to eq({{:name=>\"Abyssin\", :price=>500, :location=>\"Lviv\", :image=>\"https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg\"}}) }
  #   subject(:deals) { described_class.new(cat_type: 'Abyssin', location: 'Lviv') }
  # end
end