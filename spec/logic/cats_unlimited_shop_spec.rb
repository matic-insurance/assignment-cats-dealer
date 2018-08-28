require 'rails_helper'

describe CatsUnlimitedShop do
  let(:instance) { described_class.new }
  let(:cats_unlimited_file) { File.read('spec/data/cats_unlimited_shop.json') }
  let(:expected_endpoint) do
    'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'
  end

  let(:expected_hash) do
    [
      {
        'name' => 'Abyssin',
        'price' => 500,
        'location' => 'Lviv',
        'image' => 'https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg'
      },
      {
        'name' => 'Abyssin',
        'price' => '550',
        'location' => 'Lviv',
        'image' => 'https://olxua-ring10.akamaized.net/images_slandocomua/342850976_3_1000x700_abidetki-koti_rev006.jpg'
      }
    ]
  end

  before do
    stub_request(:get, described_class::ENDPOINT)
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip, deflate',
          'Host' => 'nh7b1g9g23.execute-api.us-west-2.amazonaws.com',
          'User-Agent' => 'rest-client/2.0.2 (darwin16.3.0 x86_64) ruby/2.4.0p0'
        }
      )
      .to_return(status: 200, body: cats_unlimited_file, headers: {})
  end

  it 'points to the correct endpoint' do
    expect(described_class::ENDPOINT).to eq expected_endpoint
  end

  it 'returns expected hash' do
    expect(instance.fetch).to eq expected_hash
  end
end
