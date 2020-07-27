shared_examples :providers_logic do
  let(:url) { Faker::Internet.url }
  let(:configuration) { { url: url } }

  let(:title) { Faker::String.random(length: 4) }
  let(:price) { Faker::Number.number(digits: 3) }
  let(:location) { Faker::Address.city }
  let(:image) { Faker::Internet.url }

  it 'parse and call decorator' do
    expect(RestClient)
      .to receive(:get).with(url).and_return(double(body: provider_response))

    expect(decorator)
      .to receive(:new).with(parsed_response).and_return(double(decorate: true))

    described_class.(configuration: configuration)
  end
end
