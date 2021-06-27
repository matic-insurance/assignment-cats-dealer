require 'rails_helper'

describe Cats::Providers::CatsUnlimitedService do
  subject(:data) { Cats::Providers::CatsUnlimitedService.instance.data }

  context 'when service responds ok' do
    let(:expected_cat) do
      {
        cat_type: 'Siamese',
        price: 20,
        location: 'Kharkiv',
        image: 'https://olxua-ring05.akamaized.net/images_slandocomua/500276292_1_1000x700_kot-po-imeni-tom-borispol.jpg'
      }
    end

    it 'returns list of cats' do
      VCR.use_cassette('/cats_unlimited/all') do
        expect(data.size).to eq 11
        expect(data.last).to eq expected_cat
      end
    end
  end

  context 'when service responds with fail' do
    it 'raises expected exception' do
      VCR.use_cassette('/cats_unlimited/failed') do
        expect { data }.to raise_error(
          ProviderUnavailableError,
          'Service "Cats Unlimited" is unavailable. Try again later'
        )
      end
    end
  end
end
