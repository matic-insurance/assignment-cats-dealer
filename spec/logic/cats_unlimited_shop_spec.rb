require 'rails_helper'

describe CatsUnlimitedShop do
  let(:instance) { described_class.new }
  let(:cats_unlimited_file) { File.read('spec/data/cats_unlimited_shop.json') }

  let(:expected_hash) do
    [
      {"name"=>"Abyssin", "price"=>500, "location"=>"Lviv", "image"=>"https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg"},
      {"name"=>"Abyssin", "price"=>"550", "location"=>"Lviv", "image"=>"https://olxua-ring10.akamaized.net/images_slandocomua/342850976_3_1000x700_abidetki-koti_rev006.jpg"},
      {"name"=>"American Curl", "price"=>450, "location"=>"Odessa", "image"=>"https://olxua-ring07.akamaized.net/images_slandocomua/113528769_3_1000x700_amerikanskie-kerly-koshki-s-chelovecheskim-litsom-koshka-kompanon-koti_rev022.jpg"},
      {"name"=>"Bengal", "price"=>700, "location"=>"Kyiv", "image"=>"https://olxua-ring10.akamaized.net/images_slandocomua/496811712_5_1000x700_bengalyata-kievskaya-oblast.jpg"},
      {"name"=>"Bobtail", "price"=>349, "location"=>"Kyiv", "image"=>"https://olxua-ring09.akamaized.net/images_slandocomua/313223928_1_1000x700_prodam-kotyat-kurilskogo-bobteyla-nikopol.jpg"},
      {"name"=>"British Shorthair", "price"=>350, "location"=>"Kyiv", "image"=>"https://olxua-ring09.akamaized.net/images_slandocomua/502753684_1_1000x700_shotladskie-kotyata-kiev.jpg"},
      {"name"=>"Devon Rex", "price"=>100, "location"=>"Kharkiv", "image"=>"https://olxua-ring02.akamaized.net/images_slandocomua/408892502_8_1000x700_malchiki-devon-reksa-drx-a-24-blue-tabby-_rev004.jpg"},
      {"name"=>"Maine Coon", "price"=>650, "location"=>"Lviv", "image"=>"https://olxua-ring08.akamaized.net/images_slandocomua/273255938_8_1000x700_kotyata-meyn-kun-ot-chempiona-mira-iz-elitnogo-pitomnika-_rev032.jpg"},
      {"name"=>"Sphynx", "price"=>230, "location"=>"Odessa", "image"=>"https://olxua-ring11.akamaized.net/images_slandocomua/478774802_2_1000x700_predlagayu-malchikov-porody-donskih-sfinksov-fotografii.jpg"},
      {"name"=>"Persian", "price"=>120, "location"=>"Odessa", "image"=>"https://olxua-ring05.akamaized.net/images_slandocomua/501982388_1_1000x700_devochka-serebristaya-shinshila-harkov_rev002.jpg"},
      {"name"=>"Siamese", "price"=>20, "location"=>"Kharkiv", "image"=>"https://olxua-ring05.akamaized.net/images_slandocomua/500276292_1_1000x700_kot-po-imeni-tom-borispol.jpg"}
    ]
  end
  it 'points to the correct endpoint' do
    expect(HappyCatsShop::ENDPOINT).to eq 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
  end

  before do
    stub_request(:get, "https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json").
        with(
            headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip, deflate',
                'Host'=>'nh7b1g9g23.execute-api.us-west-2.amazonaws.com',
                'User-Agent'=>'rest-client/2.0.2 (darwin16.3.0 x86_64) ruby/2.4.0p0'
            }).
        to_return(status: 200, body: cats_unlimited_file, headers: {})
  end

  it 'returns expected hash' do
    expect(instance.fetch).to eq expected_hash
  end
end