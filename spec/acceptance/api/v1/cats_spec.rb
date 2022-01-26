require 'acceptance_helper'

resource 'Cats' do
  header 'Content-Type', 'application/json'

  get '/api/v1/cats' do
    explanation 'Suggest the best deal for a customer'

    parameter :cat_type, 'Cat type', type: :string, with_example: true
    parameter :location, 'Customer location', type: :string, with_example: true

    example 'Getting a list of cats using filters' do
      do_request(location: 'Odessa', cat_type: 'American Curl')

      aggregate_failures('testing response') do
        record = json
        expect(status).to eq(200)
        expect(record['name']).to eq('American Curl')
        expect(record['price']).to eq(450)
        expect(record['location']).to eq('Odessa')
        expect(record['image']).to eq('https://picsum.photos/200')
      end
    end

    example 'Getting a list of cats without filters' do
      do_request

      aggregate_failures('testing response') do
        record = json
        expect(status).to eq(200)
        expect(record['name']).to eq('Devon Rex')
        expect(record['price']).to eq(100)
        expect(record['location']).to eq('Kharkiv')
        expect(record['image']).to eq('https://picsum.photos/200')
      end
    end
  end
end
