require 'rails_helper'

describe Cats::Providers::HappyCatsService do
  subject(:data) { Cats::Providers::HappyCatsService.instance.data }

  context 'when service responds ok' do
    let(:expected_cat) do
      {
        cat_type: 'Siamese',
        price: 40,
        location: 'Kharkiv',
        image: 'https://olxua-ring05.akamaized.net/images_slandocomua/500276292_1_1000x700_kot-po-imeni-tom-borispol.jpg'
      }
    end

    it 'returns list of cats' do
      VCR.use_cassette('/happy_cats/all') do
        expect(data.size).to eq 10
        expect(data.last).to eq expected_cat
      end
    end
  end

  context 'when service responds with fail' do
    it 'raises expected exception' do
      VCR.use_cassette('/happy_cats/failed') do
        expect { data }.to raise_error(
          ProviderUnavailableError,
          'Service "Happy Cats" is unavailable. Try again later'
        )
      end
    end
  end
end
