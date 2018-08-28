require 'rails_helper'

describe HappyCatsShop do
  let(:expected_endpoint) do
    'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
  end
  let(:instance) { described_class.new }
  let(:happy_cats_file) { File.read('spec/data/happy_cats_shop.xml') }

  let(:expected_hash) do
    [
      {
        'title' => 'American Curl',
        'cost' => '650',
        'location' => 'Odessa',
        'img' => "\n      https://olxua-ring07.akamaized.net/images_slandocomua/113528769_3_1000x700_amerikanskie-kerly-koshki-s-chelovecheskim-litsom-koshka-kompanon-koti_rev022.jpg\n    "
      },
      {
        'title' => 'Bengal',
        'cost' => '800',
        'location' => 'Odessa',
        'img' => 'https://olxua-ring01.akamaized.net/images_slandocomua/351717184_8_1000x700_bengalskie-kotyata-_rev029.jpg'
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
      .to_return(status: 200, body: happy_cats_file, headers: {})
  end

  it 'points to the correct endpoint' do
    expect(described_class::ENDPOINT).to eq expected_endpoint
  end

  it 'returns expected hash' do
    expect(instance.fetch).to eq expected_hash
  end
end
