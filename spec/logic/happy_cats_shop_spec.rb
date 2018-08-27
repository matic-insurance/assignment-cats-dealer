require 'rails_helper'

describe HappyCatsShop do
  let(:instance) { described_class.new }
  let(:happy_cats_file) { File.read('spec/data/happy_cats_shop.xml') }

  let(:expected_hash) do
    [
      {"title"=>"American Curl", "cost"=>"650", "location"=>"Odessa", "img"=>"\n      https://olxua-ring07.akamaized.net/images_slandocomua/113528769_3_1000x700_amerikanskie-kerly-koshki-s-chelovecheskim-litsom-koshka-kompanon-koti_rev022.jpg\n    "},
      {"title"=>"Bengal", "cost"=>"800", "location"=>"Odessa", "img"=>"https://olxua-ring01.akamaized.net/images_slandocomua/351717184_8_1000x700_bengalskie-kotyata-_rev029.jpg"},
      {"title"=>"Bengal", "cost"=>"600", "location"=>"Kyiv", "img"=>"https://olxua-ring10.akamaized.net/images_slandocomua/496811712_5_1000x700_bengalyata-kievskaya-oblast.jpg\n    "},
      {"title"=>"Bobtail", "cost"=>"369", "location"=>"Kyiv", "img"=>"\n      https://olxua-ring09.akamaized.net/images_slandocomua/313223928_1_1000x700_prodam-kotyat-kurilskogo-bobteyla-nikopol.jpg\n    "},
      {"title"=>"Devon Rex", "cost"=>"120", "location"=>"Kharkiv", "img"=>"\n      https://olxua-ring02.akamaized.net/images_slandocomua/408892502_8_1000x700_malchiki-devon-reksa-drx-a-24-blue-tabby-_rev004.jpg\n    "},
      {"title"=>"Grumpy", "cost"=>"500", "location"=>"Lviv", "img"=>"https://images-production.global.ssl.fastly.net/uploads/posts/image/47360/grumpy-cat.jpg"},
      {"title"=>"Maine Coon", "cost"=>"650", "location"=>"Lviv", "img"=>"\n      https://olxua-ring08.akamaized.net/images_slandocomua/273255938_8_1000x700_kotyata-meyn-kun-ot-chempiona-mira-iz-elitnogo-pitomnika-_rev032.jpg\n    "},
      {"title"=>"Sphynx", "cost"=>"250", "location"=>"Odessa", "img"=>"\n      https://olxua-ring11.akamaized.net/images_slandocomua/478774802_2_1000x700_predlagayu-malchikov-porody-donskih-sfinksov-fotografii.jpg\n    "},
      {"title"=>"Persian", "cost"=>"100", "location"=>"Kharkiv", "img"=>"\n      https://olxua-ring02.akamaized.net/images_slandocomua/499773040_3_1000x700_persidskiy-dlinnosherstnyy-malchik-radik-koshki.jpg\n    "},
      {"title"=>"Siamese", "cost"=>"40", "location"=>"Kharkiv", "img"=>"https://olxua-ring05.akamaized.net/images_slandocomua/500276292_1_1000x700_kot-po-imeni-tom-borispol.jpg"}
    ]
  end
  it 'points to the correct endpoint' do
    expect(HappyCatsShop::ENDPOINT).to eq 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
  end

  before do
    stub_request(:get, "https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml").
        with(
            headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip, deflate',
                'Host'=>'nh7b1g9g23.execute-api.us-west-2.amazonaws.com',
                'User-Agent'=>'rest-client/2.0.2 (darwin16.3.0 x86_64) ruby/2.4.0p0'
            }).
        to_return(status: 200, body: happy_cats_file, headers: {})
  end

  it 'returns expected hash' do
    expect(instance.fetch).to eq expected_hash
  end
end