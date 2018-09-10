require "rails_helper"
require "#{Rails.root}/lib/store_fetch_logic"

describe StoreFetchLogic do
  let(:store_xml) { file_fixture('store_xml.xml') }
  let(:store_json) { file_fixture('store_json.json') }
  let(:store_custom_json) { file_fixture('store_custom_json.json') }
  let(:xml_path) { %w[cats cat] }
  let(:parsed_store_xml) { Hash.from_xml(store_xml.read).dig(*xml_path) }
  let(:parsed_store_json) { JSON.parse(store_json.read) }
  let(:parsed_store_custom_json) { JSON.parse(store_custom_json.read) }
  let(:custom_keys) { {'picture'=> 'image', 'loc'=> 'location', 'title'=> 'name', 'cost'=> 'price'} }

  before do
    allow(described_class).to receive(:load_store_config_file)
      .and_return('catStore1'=> {'url'=> 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json',
                                'keys'=> {'image'=> 'image',
                                         'location'=> 'location',
                                         'name'=> 'name',
                                         'price'=> 'price'},
                                'format'=> 'json'},
                  'catStore2'=> {'url'=> 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml',
                                'path'=>  xml_path,
                                'keys'=> {'img'=> 'image',
                                         'location'=> 'location',
                                         'title'=> 'name',
                                         'cost'=> 'price'},
                                'format'=> 'xml'})

    stub_request(:get, "https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json")
      .with(headers: {'Accept': '*/*', 'Accept-Encoding': 'gzip, deflate',
                      'Host': 'nh7b1g9g23.execute-api.us-west-2.amazonaws.com',
                      'User-Agent': 'rest-client/2.0.2 (linux-gnu x86_64) ruby/2.4.4p296'})
      .to_return(status: 200, body: store_json, headers: {})

    stub_request(:get, "https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml")
      .with(headers: {'Accept': '*/*', 'Accept-Encoding': 'gzip, deflate',
                      'Host': 'nh7b1g9g23.execute-api.us-west-2.amazonaws.com',
                      'User-Agent': 'rest-client/2.0.2 (linux-gnu x86_64) ruby/2.4.4p296'})
      .to_return(status: 200, body: store_xml, headers: {})
  end

  it 'StoreFetchLogic#perform' do
    parsed_records = parsed_store_json + parsed_store_xml
    expect(CatsStore.count).to eq(0)
    described_class.perform
    expect(CatsStore.count).to eq(parsed_records.count)
  end

  it 'StoreFetchLogic#normalize_if_needed' do
    allow(described_class).to receive(:load_store_config_file)
      .and_return('catStore1'=> {'url'=> 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json',
                                'keys'=> custom_keys, 'format'=> 'json'})
    res = described_class.normalize_if_needed(parsed_store_custom_json, custom_keys)
    expect(res.first.keys).to eq(parsed_store_json.first.keys)
  end

  it 'StoreFetchLogic#update_cites_and_names' do
    expect(City.count).to eq(0)
    expect(CatName.count).to eq(0)
    described_class.update_cites_and_names(parsed_store_json)
    expect(City.count).to eq(4)
    expect(CatName.count).to eq(10)
  end
end
